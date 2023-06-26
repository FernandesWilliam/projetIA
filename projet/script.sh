#!/bin/bash

script_name='./TER/delay_learning_v3.py'

declare -A parameters=(
  ["--grid-input"]=13
  ["--nb-convolution"]=2
  ["--size-filter"]=5
)

param_string() {
  local params=""
  for key in "${!parameters[@]}"; do
    params+=" $key ${parameters[$key]}"
  done
  echo $params
}

convolution_change() {
  for ((i=4; i<=33; i+=6)); do
    parameters['--nb-convolution']=$i
    python3 $script_name nest --plot-figure $(param_string)
  done
}

grid_input() {
  for ((i=13; i<=53; i+=13)); do
    parameters['--grid-input']=$i
    echo "parameters" "${parameters[@]}"
    python3 $script_name nest --plot-figure $(param_string)
  done
}

size_filter() {
  for ((i=5; i<=10; i+=5)); do
    parameters['--size-filter']=$i
    if [[ $i -eq 5 ]]; then
      parameters['--grid-input']=13
    else
      parameters['--grid-input']=26
    fi
    python3 $script_name nest --plot-figure $(param_string)
  done
}

# Metrique
for ((i=1; i<=$#; i++)); do
  arg="${!i}"
  if [[ $arg == 'grid' ]]; then
    grid_input
  elif [[ $arg == 'conv' ]]; then
    convolution_change
  elif [[ $arg == 'filter' ]]; then
    size_filter
  fi
done