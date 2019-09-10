#!/bin/bash
pamixer -t && if pamixer --get-mute; then volnoti-show -m; else volnoti-show $(pamixer --get-volume); fi
