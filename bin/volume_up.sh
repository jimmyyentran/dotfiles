#!/bin/bash
pamixer --allow-boost --unmute -i $1 && volnoti-show $(echo $(pamixer --get-volume)/200*100 | bc -l)
