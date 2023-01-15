# Bash functions to ease work on the University of Oklahoma's Supercomputer 

The University of Oklahoma's supercomputer is called schooner and is run by the 
Oklahoma Center for Supercomputing Education and Research [(OSCER)](https://www.ou.edu/oscer).

The supercomputer uses the [SLURM](https://slurm.schedmd.com/overview.html) job queuing software. 
Some of the functions ease the use of this system.
Other functions ease doing boring tasks.

These functions can be adapted to run on local machines too (Mac OSX and Linux)!
The file paths will need editing.
The bash script calls two Python scripts in the subfolder.

May this script inspire you to write new bash functions!

## Usage in bash or zsh shells

These functions work in either bash or zsh shells.
Source the .bashFunctions file from your .bashrc or .zshrc file.
Then enter the function name in the terminal and hit return or enter to get a printout in the terminal of the documentation, which incudes examples. 

## Useful functions of note

- The *gac* function combines `git add` and `git commit -m`.
- The *take* function combines `mkdir` and `cd` to the new directory.
- The *rmspaces* function removes those annoying whitespaces in the filenames of all files in the current directory.
- The *rmunderscores* function removes underscores in the filenames of all files in the current directory.
- The *rmcommas* function removes commas in the filenames of all files in the current directory.


## Table of function names and descriptions (planned)


## Related repos

- [emacs4oscer](https://github.com/MooersLab/emacs4oscer)
- [vimrc4oscer](https://github.com/MooersLab/vimrc4oscer)
