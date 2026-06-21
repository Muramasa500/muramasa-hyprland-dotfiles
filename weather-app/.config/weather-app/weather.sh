#!/bin/bash

# Log directory for debugging
LOG_DIR="$HOME/.local/share/weather-app/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/weather.log"

# Redirect debug to log file only, keep stdout clean for Waybar
exec 3>&1  # Save original stdout
exec 1>"$LOG_FILE" 2>&1  # Redirect all output to log file
exec 4>&1  # Save log file descriptor

# Function to output to log only
log() {
    echo "$@" >&4
}

# Function to output to Waybar (stdout)
output_waybar() {
    echo "$@" >&3
}

log "=== $(date '+%Y-%m-%d %H:%M:%S') ==="
log "Script started"

# Read geolocation file
GEOLOC_FILE="$HOME/.config/weather-app/geolocation"

log "Reading geolocation file: $GEOLOC_FILE"
if [ ! -f "$GEOLOC_FILE" ]; then
    log "ERROR: geolocation file not found"
    output_waybar "{\"text\": \"Error: geolocation file not found\", \"tooltip\": \"Check $GEOLOC_FILE\"}"
    exit 1
fi

# Extract coordinates from file
COORDS=$(grep -v '^[[:space:]]*#' "$GEOLOC_FILE" | grep -v '^[[:space:]]*$' | head -1)
log "Raw coordinates line: '$COORDS'"

if [ -z "$COORDS" ]; then
    log "ERROR: No coordinates found in geolocation file"
    output_waybar "{\"text\": \"Error: No coordinates\", \"tooltip\": \"Check geolocation file format\"}"
    exit 1
fi

# Parse comma-separated coordinates
LAT=$(echo "$COORDS" | cut -d',' -f1 | xargs)
LON=$(echo "$COORDS" | cut -d',' -f2 | xargs)

log "Parsed LAT: '$LAT'"
log "Parsed LON: '$LON'"

# Fetch weather data
API_URL="https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current=temperature_2m,weather_code,wind_speed_10m,precipitation_probability&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=celsius"

log "API URL: $API_URL"
log "Fetching from Open-Meteo..."

RESPONSE=$(curl -s -w "\n%{http_code}" "$API_URL")
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
RESPONSE_BODY=$(echo "$RESPONSE" | head -n-1)

log "HTTP Status Code: $HTTP_CODE"
log "Full API Response:"
echo "$RESPONSE_BODY" | jq . 2>&1 >> "$LOG_FILE" || echo "$RESPONSE_BODY" >> "$LOG_FILE"

# Validate JSON
if ! echo "$RESPONSE_BODY" | jq . > /dev/null 2>&1; then
    log "ERROR: Invalid JSON response"
    output_waybar "{\"text\": \"Error: Invalid JSON\", \"tooltip\": \"API response invalid\"}"
    exit 1
fi

log "JSON validation: OK"

# Function to safely escape JSON strings
json_escape() {
    printf '%s' "$1" | jq -Rs '.'
}

# Function to convert WMO weather code to an icon
get_icon() {
    local code="$1"
    case "$code" in
        0|1) echo "☀️" ;;
        2) echo "⛅" ;;
        3) echo "☁️" ;;
        45|48) echo "🌫️" ;;
        51|53|55) echo "🌧️" ;;
        61|63|65) echo "🌧️" ;;
        71|73|75) echo "❄️" ;;
        77) echo "❄️" ;;
        80|81|82) echo "🌧️" ;;
        85|86) echo "❄️" ;;
        95|96|99) echo "⛈️" ;;
        *) echo "🌡️" ;;
    esac
}

# Extract data with detailed error checking
log "--- Extracting current data ---"

CURRENT_TEMP=$(echo "$RESPONSE_BODY" | jq '.current.temperature_2m // 0 | round')
log "CURRENT_TEMP: $CURRENT_TEMP"

CURRENT_CODE=$(echo "$RESPONSE_BODY" | jq '.current.weather_code // 0')
log "CURRENT_CODE: $CURRENT_CODE"

CURRENT_WIND=$(echo "$RESPONSE_BODY" | jq '.current.wind_speed_10m // 0 | round')
log "CURRENT_WIND: $CURRENT_WIND"

CURRENT_RAIN=$(echo "$RESPONSE_BODY" | jq '.current.precipitation_probability // 0')
log "CURRENT_RAIN: $CURRENT_RAIN"

log "--- Extracting daily data ---"

TODAY_HIGH=$(echo "$RESPONSE_BODY" | jq '.daily.temperature_2m_max[0] // 0 | round')
TODAY_LOW=$(echo "$RESPONSE_BODY" | jq '.daily.temperature_2m_min[0] // 0 | round')
TODAY_CODE=$(echo "$RESPONSE_BODY" | jq '.daily.weather_code[0] // 0')
TODAY_PRECIP=$(echo "$RESPONSE_BODY" | jq '.daily.precipitation_sum[0] // 0')

# TODO: change name to DAY1, DAY, and so on
log "TODAY_HIGH: $TODAY_HIGH, TODAY_LOW: $TODAY_LOW, TODAY_CODE: $TODAY_CODE, TODAY_PRECIP: $TODAY_PRECIP"

TOMORROW_HIGH=$(echo "$RESPONSE_BODY" | jq '.daily.temperature_2m_max[1] // 0 | round')
TOMORROW_LOW=$(echo "$RESPONSE_BODY" | jq '.daily.temperature_2m_min[1] // 0 | round')
TOMORROW_CODE=$(echo "$RESPONSE_BODY" | jq '.daily.weather_code[1] // 0')

log "TOMORROW_HIGH: $TOMORROW_HIGH, TOMORROW_LOW: $TOMORROW_LOW, TOMORROW_CODE: $TOMORROW_CODE"

DAYAFTER_HIGH=$(echo "$RESPONSE_BODY" | jq '.daily.temperature_2m_max[2] // 0 | round')
DAYAFTER_LOW=$(echo "$RESPONSE_BODY" | jq '.daily.temperature_2m_min[2] // 0 | round')
DAYAFTER_CODE=$(echo "$RESPONSE_BODY" | jq '.daily.weather_code[2] // 0')

# TODO: Add more days here

log "DAYAFTER_HIGH: $DAYAFTER_HIGH, DAYAFTER_LOW: $DAYAFTER_LOW, DAYAFTER_CODE: $DAYAFTER_CODE"

# Get icons
log "--- Converting codes to emojis ---"
CURRENT_EMOJI=$(get_icon "$CURRENT_CODE")
log "CURRENT_EMOJI: $CURRENT_EMOJI"

TODAY_ICON=$(get_icon "$TODAY_CODE")
TOMORROW_ICON=$(get_icon "$TOMORROW_CODE")
DAYAFTER_ICON=$(get_icon "$DAYAFTER_CODE")

log "TODAY_EMOJI: $TODAY_ICON, TOMORROW_EMOJI: $TOMORROW_ICON, DAYAFTER_EMOJI: $DAYAFTER_ICON"

# Get weekday names in English
log "--- Getting weekday names ---"
FORCAST_DAY1=$(LC_TIME=en_US.UTF-8 date -d "+1 day" "+%A")
FORCAST_DAY2=$(LC_TIME=en_US.UTF-8 date -d "+2 days" "+%A")
# FORCAST_DAY3=$(LC_TIME=en_US.UTF-8 date -d "+3 days" "+%A")
# FORCAST_DAY4=$(LC_TIME=en_US.UTF-8 date -d "+4 days" "+%A")
# FORCAST_DAY5=$(LC_TIME=en_US.UTF-8 date -d "+5 days" "+%A")

log "FORCAST_DAY1: $FORCAST_DAY1"
log "FORCAST_DAY2: $FORCAST_DAY2"
# log "FORCAST_DAY3: $FORCAST_DAY3"
# log "FORCAST_DAY4: $FORCAST_DAY4"
# log "FORCAST_DAY5: $FORCAST_DAY5"

# Format text for Waybar
TEXT="${CURRENT_TEMP}°C ${CURRENT_EMOJI}"
log "TEXT output: $TEXT"

# Build tooltip
TOOLTIP="<b><span foreground='#FFD700'>Current</span></b>
Weather:  ${CURRENT_TEMP}°C ${CURRENT_EMOJI}
Rain:     ${CURRENT_RAIN}% (${TODAY_PRECIP} mm)
Wind:     ${CURRENT_WIND} m/s

<b><span foreground='#87CEEB'>Forcast</span></b>
<b><span foreground='#87CEEB'>Today</span></b>:    ${TODAY_LOW}° / ${TODAY_HIGH}° ${TODAY_EMOJI}
<b><span foreground='#90EE90'>${FORCAST_DAY1}</span></b>:   ${TOMORROW_LOW}° / ${TOMORROW_HIGH}° ${TOMORROW_EMOJI}
<b><span foreground='#FFB6C1'>${FORCAST_DAY2}</span></b>:   ${DAYAFTER_LOW}° / ${DAYAFTER_HIGH}° ${DAYAFTER_EMOJI}"
# <b><span foreground='#F08080'>${FORCAST_DAY3}</span></b>: L:${DAYAFTER_LOW}° H:${DAYAFTER_HIGH}° ${DAYAFTER_EMOJI}"
# <b><span foreground='#F0E68C'>${FORCAST_DAY4}</span></b>: L:${DAYAFTER_LOW}° H:${DAYAFTER_HIGH}° ${DAYAFTER_EMOJI}"
# b><span foreground='#DDA0DD'>${FORCAST_DAY5}</span></b>: L:${DAYAFTER_LOW}° H:${DAYAFTER_HIGH}° ${DAYAFTER_EMOJI}"

# Escape for JSON output
log "--- Escaping for JSON ---"
TEXT_ESCAPED=$(json_escape "$TEXT")
log "TEXT_ESCAPED: $TEXT_ESCAPED"

TOOLTIP_ESCAPED=$(json_escape "$TOOLTIP")
log "TOOLTIP_ESCAPED (first 200 chars): ${TOOLTIP_ESCAPED:0:200}..."

# Output JSON for Waybar
OUTPUT="{\"text\": $TEXT_ESCAPED, \"tooltip\": $TOOLTIP_ESCAPED, \"class\": \"weather\"}"
log "--- Final output ---"
log "$OUTPUT"
log ""

# Output to Waybar (only this goes to stdout)
output_waybar "$OUTPUT"
