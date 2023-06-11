"""Functions used in preparing Guido's gorgeous lasagna.

Learn about Guido, the creator of the Python language:
https://en.wikipedia.org/wiki/Guido_van_Rossum

This is a module docstring, used to describe the functionality
of a module and its functions and/or classes.
"""

EXPECTED_BAKE_TIME = 40
PREPARATION_TIME_PER_LAYER = 2


def bake_time_remaining(minutes_in_oven):
    """Calculate the bake time remaining.

    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - remaining bake time (in minutes) derived from 'EXPECTED_BAKE_TIME'.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """
    return EXPECTED_BAKE_TIME - minutes_in_oven


def preparation_time_in_minutes(number_of_layers):
    """Calculate how many minutes a lasanga will take to prepare.

    :param number_of_layers: int - number of layers of the lasagna.
    :return: int - total time spent (in minutes) to prepare the lasagna

    Function that takes the number of lasagna layers and returns how many
    minutes are spent to prepare the lasagna.
    """
    return PREPARATION_TIME_PER_LAYER * number_of_layers


def elapsed_time_in_minutes(number_of_layers, elapsed_bake_time):
    """Calculate the elapsed time in minutes.

    :param number_of_layers: int - number of layers of the lasagna.
    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - total time spent (in minutes) including preparation & baking

    Function that takes the number of lasagna layers and the time in the oven
    returns how many minutes has been spent in total preparing and baking the
    lasagna.
    """
    return preparation_time_in_minutes(number_of_layers) + elapsed_bake_time
