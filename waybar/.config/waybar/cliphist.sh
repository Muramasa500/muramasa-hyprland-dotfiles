#!/bin/bash
cliphist list | \
fuzzel --dmenu -p "Cliphist ❯" --width 45 --lines 25| \
cliphist decode | \
wl-copy
