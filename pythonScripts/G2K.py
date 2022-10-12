#!/usr/bin/env python3
from math import exp
import sys
"""
OU Board of Regents

Blaine Mooers, PhD
OUHSC
4 April 2019

MIT License
"""
print('Usage: G2K.py <deltaG in kcal/mol>')
print('Assume standard conditions at 25C.')
RT = 0.592

try:
    deltaG = sys.argv[1]
except:
    print('Please provide Gibbs free energy in Kcal/mol after ./G2K.py on the command line! Please include the proper sign.')

fdeltaG = float(deltaG)

print('Entered delta G (kcal/mol): ', deltaG)

Keq = exp(fdeltaG/RT)
print('Keq = ', '{:.3e}'.format(Keq))
