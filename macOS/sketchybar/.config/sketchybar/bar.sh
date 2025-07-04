#!/bin/bash

bar=(
  position=top
  height=37
  margin=12
  corner_radius=16
  color="$BAR_COLOR"
)

sketchybar --bar "${bar[@]}"
