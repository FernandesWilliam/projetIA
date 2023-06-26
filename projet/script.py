import os
import sys

script_name = './TER/delay_learning_v3.py'

parameters = {
    "--grid-input": 13,
    "--nb-convolution": 2,
    "--size-filter": 5,
}

param_string = lambda params: " ".join(map(lambda key: f"{key} {params[key]}", params.keys()))


def convolution_change(parameters):
    for i in range(4, 33, 6):
        parameters['--nb-convolution'] = i
        os.system(f"python3 {script_name} nest --plot-figure {param_string(parameters)}")


def grid_input(parameters):
    for i in range(13, 53, 13):
        parameters['--grid-input'] = i
        print("prameters", parameters)
        os.system(f"python3 {script_name} nest --plot-figure {param_string(parameters)}")


def size_filter(parameters):
    for i in range(5, 11, 5):
        parameters['--size-filter'] = i
        parameters['--grid-input'] = 13 if i == 5 else 26
        os.system(f"python3 {script_name} nest --plot-figure {param_string(parameters)}")


## evalutaiton des metriques
for i in range(1, len(sys.argv)):
    arg = sys.argv[i]
    if arg == 'grid':
        grid_input(parameters)
    if arg == 'conv':
        convolution_change(parameters)
    if arg == 'filter':
        size_filter(parameters)
