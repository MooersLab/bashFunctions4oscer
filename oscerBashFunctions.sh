# My bash functions for working on remote computers like the U of Oklahoma supercomputer, which uses the SLURM job queueing software. 
# These functions can be adapted for use a local unix-like computer.
# 
# I source this file from my .bashrc. 
# You have to source .bashrc or .bashBashAliases to reactivate after editing.
#
# Use "return" instead of "exit" in the functons of sourced bash files. 
#
# The use of Vim to edit files can lead to inserting colons where unintended when escaping the insert mode to go into the command mode. 
# These misplaced colons can raise hell! 
# You can use nano (or Emacs :) ) instead.


####### aliases to bash commands

# bash functions

function bs {
echo "Change shell to bash"
ehco "Usage: bs"
chsh -s /bin/bash
}

### C

function ccase {
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: rename orignal replacement"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: ccase phrase"
fi
    echo "$1"
    arr=($1)
    printf %s "${arr[@]^}"
}


function continueSir {
echo "Function to continue SIR2014 trials."
echo "Usage: consir2014"
echo "Run mvdone finished.txt 2371aug22' first"
rm unfinished.txt &&
uf > unfinished.txt &&
nohup ./relaunch.sh 2371tpsdm &
}

function ci {
echo "Checking in on jobs running on Schooner."
cj &&
ds &&
echo "Change directory to ./sir2014trials/2371tpsdm" &&
2371 &&
cntpdb &&
echo "Count unfinished trials." &&
cntuf &&
echo "Consider runing a command like: mvdone2scratch finished.txt 2371tpsdm23August2019"
}


function cj {
echo "cj ==: checkjobs.sh"
echo "List pending and running jobs for user bmooers."
printf  "Pending Jobs\n" &&
squeue -u bmooers -t PENDING -o "%.10i %.24P %.8j %.8u %.8T %.10M %.9l %.6D %R" | sed -n 'p;$=' &&
printf "\nRunning Jobs\n" &&
squeue -u bmooers -t RUNNING -o "%.10i %.24P %.8j %.8u %.8T %.10M %.9l %.6D %R" | sed -n 'p;$='
}

function cpending {
echo "Check pending jobs:"
printf  "Pending Jobs\n" &&
squeue -u bmooers -t PENDING -o "%.10i %.24P %.8j %.8u %.8T %.10M %.9l %.6D %R" | sed -n 'p;$='
}


function crunning {
echo "Check running jobs for bmooers:"
printf  "Running Jobs\n" &&
squeue -u bmooers -t RUNNING -o "%.10i %.24P %.8j %.8u %.8T %.10M %.9l %.6D %R" | sed -n 'p;$='
}


function cs {
echo="Change shell to csh"
echo="Usage: cs"
chsh -s /bin/csh
}

function dcase {
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: rename orignal replacement"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: dcase phrase."
fi
    echo "$1"
    arr=($1)
    printf %s "${arr[@]^}"
}

# spinal_to_upper "some-string-like-this"
# returns "SomeStringLikeThis"
function spinal_to_upper{
IFS=- read -ra str <<<"$1"
printf '%s' "${str[@]^}"
}

function cntfiles {
echo "Count the files in the directory."
echo "Usage: cntfiles."
find . -type f | wc -l
}

function cntdir {
echo "Count the directories in the current directory."
echo "Usage: cntdir"
find . -mindepth 1 -maxdepth 1 -type d | wc -l
}

function cntabi {
echo "Count the number of *_abi.mtz files in subfolders."
echo "Usage: cntmtz"
ls -dq */*_abi.mtz | wc -l
}

function cntpdb {
echo "Count the number of pdb files in subfolders."
echo "Usage: cntpdb"
ls -dq */*.pdb | wc -l
find ./ -mindepth 1 -maxdepth 1 -type d '!' -exec test -e "{}/*_([1-9999]|****).pdb" ';' -print | wc -l
}

function cntTrials {
echo "Count the number of Trails attemptedminus 1"
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: cntTrials 1524.out"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: cntTrials 1524.out"
  return 2
fi
#!/bin/bash
x=$(grep -o Trial "$1" | wc -l)
y=$(($x - 1))
printf "%d\t%s\n" $y "Trials run"
echo "Success!"
}

function cntuf {
echo "Count subfolders in a project directory without a pdb file."
echo "Usage: cntuf"
find ./ -type d -name '*startphase*' | while read a ;
do if [ ! -f $a/*_****.pdb ];
then echo $a;
fi;
done | wc -l
}

function cntTimedOut {
echo "Count subfolders in a project directory without a pdb file."
echo "Usage: cntuf"
find ./ -type d -name '*startphase*' | while read a ;
do if [ ! -f $a/*_****.pdb ];
then echo $a;
fi;
done | wc -l
}

function ct {
echo "Compile tex file and open with skim."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: ./compile.sh baseOfTexFileName"
  echo "Note absence of file extension .tex"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2:
 "$0: too many arguments"
  echo "Usage: ct baseOfTexFileName"
  echo "Note absence of file extension .tex"
  return 2
fi

#filename=$(basename -- "$1")
#extension="${filename##*.}"

#if extension=".tex"; then
#  echo "Do NOT supply the file extension."
#fi

#if extension=".ltx"; then
#  echo "Do NOT supply the file extension."
#fi

pdflatex -shell-escape "$1".tex &&
open -a Skim "$1".pdf
}

### D

function dirtree {
echo "Get directory tree of specified directory. May have to install tree from external repository."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: dirtree <dir>"
  echo "Example: tree -F -a --dirsfirst 512RNAdrugCrystallization"
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: dirtree <dir>"
  echo "Example: tree -F -a --dirsfirst 512RNAdrugCrystallization"
fi
tree -F -a --dirsfirst $1;
}

function dssr {
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: rename orignal replacement"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: dssr filestemOfPDBfile"
  echo "Note add ^ in front of first argument when phrase is at the beginning of the line."
fi
echo "Runs dssr on RNA."
echo "Usage: dssr filestemOfPDBfile."
mkdir $1'dssrAnalysis'
cd $1'dssrAnalysis'
x3dna-dssr -i='../'$1.'pdb'
cd ..
}

### E

### F


### G

function G2K {
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Convert Gibbs Free energy to partition coefficient K."
  echo "Usage: ./G2K.py -8.2"
  echo "Note that the delta G knot is in kcal/mol."
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: ./G2K.py -8.2"
  echo "Note absence of file extension .tex"
fi
/home/bmooers/pythonScripts/G2K.py $1;
}

function gac {
echo "Function to git add a file and then commit the changes with a message."
echo "Takes the name of a file and the message in a string."
echo "Must set up repository in advance of using this function."
if [ $# -lt 2 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: gca filename 'message about the commit'"
  return 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: gct "
  echo "Note absence of file extension .tex"
  return 2
fi
git add "$1" 
git commit -m "$2" "$1"
}



function gct {
echo "Function to git commit changes to one tex file."
echo "Takes the basename as a command line argument."
echo "Must set up repository in advance of using."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: gct baseOfTexFileName"
  echo "Note absence of file extension .tex"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: gct "
  echo "Note absence of file extension .tex"
  return 2
fi
git add "$1".tex
git commit -m "Added new text in $1.tex" "$1".tex
}

function gcpml {
echo "Function to git commit changes to one tex file."
echo "Takes the basename as a command line argument."
echo "Must set up repository in advance of using."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: gct baseOfTexFileName"
  echo "Note absence of file extension .pml"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: gct baseOfTexFileName"
  echo "Note absence of file extension .pml"
  return 2
fi

git add "$1".pml
git commit -m "Added new text in $1.pml" "$1".pml
}

function gcpy {
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: gct baseOfTexFileName"
  echo "Note absence of file extension .tex"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: gct baseOfTexFileName"
  echo "Note absence of file extension .tex"
  return 2
fi
echo "Function to git commit changes to one py file."
echo "Takes the basename as a command line argument." 
echo "Must set up repository in advance of using."

git add "$1".py
git commit -m "Added new text in $1.py" "$1".py
}

function gcr {
echo "Function to git commit changes to one *.R file."
echo "Takes the basename as a command line argument."
echo "Must set up repository in advance of using."

if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: gcr baseOfTexFileName"
  echo "Note absence of file extension .R"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: gcr baseOfTexFileName"
  echo "Note absence of file extension .R"
  return 2
fi

git add "$1".R
git commit -m "Added new text in $1.R" "$1".R
}

function getpdb{
echo "Get PDB coordinate file from the Protein Data Bank."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: getpdb <pdb-id>"
  echo "Example: getpdb 4rj1."
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: getpdb <pdb-id>"
  echo "Example: getpdb 4rj1."
fi
/Users/blaine/Scripts/PythonScripts/pdb_get.py $1;
}

function google {
echo "send a search term to google from the command line"
echo "Example: google OUHSC biochemistry"
echo "Example: google OUHSC Links for Molecular Structure Analysis" 
search=""
echo "Googling: $@"
for term in $@; do
        search="$search%20$term"
done
open "http://www.google.com/search?q=$search"
}

### H 
function helan {
echo "Runs X3DNA's find_pair and analyze on dsRNA."
echo "Usage: helanl filestemOfPDBfile."
mkdir $1'helcialAnalysis'
cd ./$1'helcialAnalysis'
$X3DNA/bin/find_pair -s ../$1'.pdb' $1'.inp'
$X3DNA/bin/analyze $1'.inp'
}

### I







### J
function jpt {
# Fires-up a Jupyter notebook by supplying a specific port
jupyter notebook --no-browser --port=$1
}


### K


### L

function lsf {
echo "Current path: $PWD" 
ls -ltrG
}


function lsnoabi {
echo "List folders with *_abi.mtz absent."
find `pwd` -mindepth 1 -maxdepth 1 -type d '!' -exec test -e "{}/{}_abi.mtz" ';' -print
}

function lsnoabi2 {
echo "List folders with *_abi.mtz absent. Max depth of 2."
find `pwd` -mindepth 1 -maxdepth 2 -type d '!' -exec test -e "{}/{}_abi.mtz" ';' -print
}

function lsabi {
echo "List all subfolders with *_abi.mtz present."
find `pwd` -name "*"_abi.mtz -print
}

function lspdb {
#echo "List all subfolders with *.pdb present. Print the path but not the pdb file."
find `pwd` -name "*".pdb -exec dirname {} \; 
}

### M
#mvdone()
#{
#echo "Move folders in list in a text file. One folder per line."
#echo ""
#echo "Finds the folders with pdb files and writes the full path to txt file."
#echo "Takes the name of this file and name of the folder one level up."
#echo "Usage: mvdone finished.txt 1556done"
#if [ $# -lt 2 ]; then
#  echo 1>&2 "$0: not enough arguments"
#  echo "Usage: mvList finished.txt 1556Done"
#  return 2
#elif [ $# -gt 2 ]; then
#  echo 1>&2 "$0: too many arguments"
#  echo "Usage: mvdone finished.txt 1556done"
#  return 2
#fi
#lspdb  > $1
#mkdir ../$2
#for folder in $(cat $1); 
#    do mv "$folder" /home/bmooers/sir2014_trials/$2; 
#done
#}



function mvdone2home {
echo "mvdone2home()"
echo ""
echo "Move folders in list in a text file finished.txt to /home/bmooers. One folder per line."
echo "Use when the scratch drive is not available."
echo ""
echo "Finds the folders with pdb files and writes the full path to a txt file."
echo "Takes as arguments the name of this txt file and name of the new folder in the home folder."
echo "Usage: mvdone2home finished.txt FolderStemDone"
if [ $# -lt 2 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: mvList finished.txt 1556Done"
  return 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: mvdone finished.txt 1556done"
  return 2
fi
mkdir /home/bmooers/$2
lspdb  > /home/bmooers/$2/$1
for folder in $(cat /home/bmooers/$2/$1);
    do mv "$folder" /home/bmooers/$2;
done
echo ""
echo "Moved finished jobs to /home/bmooers/$2. Take care not to overwrite this folder."
}



function mvdone2scratch {
echo "mvdone2scratch()"
echo ""
echo "Move folders in list in a text file finished.txt to /scatch/bmooers. One folder per line."
echo ""
echo "Finds the folders with pdb files and writes the full path to a txt file."
echo "Takes as arguments the name of this txt file and name of the new folder on the scratch disk."
echo "Usage: mvdone2scratch finished.txt FolderStemDone"
if [ $# -lt 2 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: mvList finished.txt 1556Done"
  return 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: mvdone finished.txt 1556done"
  return 2
fi
mkdir /scratch/bmooers/$2
lspdb  > /scratch/bmooers/$2/$1
for folder in $(cat /scratch/bmooers/$2/$1);
    do mv "$folder" /scratch/bmooers/$2;
done
echo "Moved finished jobs to /scratch/bmooers/$2. Take care not to overwrite this folder. Folders can remain on the scarch disk."
}




### N

### O

### P

function pdfcropall {
echo "pdfcrop all pdfs in a directory by trimming away the white borders."
echo "Usage: pdfcropall"
echo "pdbcrop must be installed. "

for FILE in ./*.pdf 
  do 
    pdfcrop "${FILE}" "${FILE}"
  done
}


function pyc {
echo "Evaluate simple math expressions with Python. Math expression must be passed inside double quotes."
echo 'Example1 using built-in: pyc "110./10."'
echo 'Example2 using the math module: pyc "math.sin(math.radians(90))"'
echo 'To see the available math functions, enter python -c "import math;print(dir(math))"'
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo 'Example: pyc "110./10."'
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo 'Example: pyc "110./10."'
fi
python -c 'import math;print(eval("'$1'"))'
}

alias dzpdf="rename 's/\(z-lib.org\)./\./' *.pdf"
alias dzepub="rename 's/\(z-lib.org\)./\./' *.epub"

### Q


### R
function rmcommas {
echo "Remove commas in all filenames in a directory"
echo "Usage: rmcommas"
for f in *,*;
  do
    mv "$f" "${f//,/}";
  done
}


function rmduplicates {
echo "Remove duplicate files. This function will remove those duplicate pdfs that you downloaded."
echo "This function requires bash version 4.0+ because it has the array function."
echo "The default bash on Mac is older than version 4.0. Install a newer bash with macports or fink or homebrew." 

declare -A arr
shopt -s globstar

for file in **; 
  do
   [[ -f "$file" ]] || continue
    read cksm _ < <(md5sum "$file")
    if ((arr[$cksm]++)); then 
      echo "rm $file"
    fi
  done
}


function rmspaces {
echo "Remove whitespaces in all filenames in a directory"
echo "Usage: rmspaces"
for f in *\ *;
  do
    mv "$f" "${f// /}";
  done
}


function rmunderscores {
echo "Remove underscores in all filenames in a directory"
echo "Usage: rmscores"
for f in *_*;
  do
    mv "$f" "${f//_/}";
  done
}


#redoLaunch()
#{
#echo "Write the unfinished jobs to a txt file. Loop over this file and write a new launch script."
#echo "Usage: redoLaunch $1"
#if [ $# -lt 1 ]; then
#  echo 1>&2 "$0: not enough arguments"
#  echo "Usage: redoLaunch prefix"
#  echo "Example: redoLaunch $1"
#  return 2
#elif [ $# -gt 1 ]; then
#  echo 1>&2 "$0: too many arguments"
#  echo "Usage: redoLaunch prefix prefix"
#  exho "Example: redoLaunch $1"
#  return 2
#fi
#
#rm unfinished.txt
#rm newLaunch.sh
#find `pwd` -type d -name '*startphase*' | while read a ;
#do if [ ! -f $a/*_****.pdb ];
#	then printf '%s\n' $a >> unfinished.txt
#fi
#done
#echo "Finished writing 'unfinished.txt'  (:"
#for folderpath in $(cat unfinished.txt);
#    do printf 'sbatch %s/$1.sbatch; sleep 1m;\n' "$folderpath"  >> newLaunch.sh
#done
#echo "Finished writing a new 'newLaunch.sh' file  (:"
#}


#relaunch(){
#echo "Relaunch timed out jobs. Must run uf > unfinished.txt first."
#echo "May want to shorten the list of jobs run at one time."
#
#if [ $# -lt 1 ]; then
#  echo 1>&2 "$0: not enough arguments"
#  echo "Usage: ./relaunch.sh prefix"
#  echo "Example: ./relaunch.sh 1524"
#  return 2
#elif [ $# -gt 1 ]; then
#  echo 1>&2 "$0: too many arguments"
#  echo "Usage: ./relaunch.sh prefix prefix"
#  exho "Example: ./relaunch.sh 1524"
#  return 2
#fi
#count=1
#for folderpath in $(cat unfinished.txt);
#do
#    cp restart.sh "$folderpath"/.;
#    cd "$folderpath";
#    echo "$folderpath";
#    "$folderpath"/restart.sh "$1";
#    echo 'Launched job "$count" in "$folderpath"';
#    count=`expr $count + 1`
#done
#echo 'Finished relaunching "$count" jobs (:'
#}


function rename {
echo "Rename filenames in current folder with the Rename.py script." 
if [ $# -lt 2 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: rename orignal replacement"
  return 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: rename orignal replacement"
  echo "Note add ^ in front of first argument when phrase is at the beginning of the line."
  return 2
fi
/home/bmooers/pythonScripts/rename.py . '$1' '$2' -s -w
}

# repeat a command a specific number of times
function repeat {
echo "Example usage: repeat 61 ./quizDP.py"
echo "The first argument is the time in seconds that the script is delayed."
echo " "
echo "If the script needs to run multiple times"
echo "every n seconds, try the whileLoop alias" 
echo "or the script ./Scripts/BashScripts/whileLoop.sh."
n=$1
shift
while [ $(( n -= 1 )) -ge 0 ]
do
    "$@"
done
}

function resubmit {
echo "Resubmit unfinsihed jobs to the queue."
echo "Usage: resubmit sirjobname"
echo "Example: resubmit 2371tpsdm"
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  return 2
fi
rm unfinished.txt &&
uf > unfinished.txt && 
nohup ./relaunch.sh $1 & 
}

function rmspaces {
echo "Remove whitespaces in all filenames in a directory"
echo "Usage: rmspaces"
for f in *\ *; 
  do 
    mv "$f" "${f// /}"; 
  done
}

### S

function shortcursor {
echo "Make shortcursor."
echo "Usage: shortcursor"
PS1='\u:\W\$ '  
}

### T

# Source:  Bozhidar Batsov https://batsov.com/
function take {
  if [[ $1 =~ ^(https?|ftp).*\.tar\.(gz|bz2|xz)$ ]]; then
    takeurl "$1"
  elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit "$1"
  else
    takedir "$@"
  fi
}


function tre {
echo "Get directory tree of specified directory. May have to install tree from external repository."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: tre <dir>"
  echo "Example: tree -F -a --dirsfirst 512RNAdrugCrystallization"
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage: tre <dir>"
  echo "Example: tree -F -a --dirsfirst 512RNAdrugCrystallization"
fi
tree -F -a --dirsfirst $1;
}



### U

function uf {
echo "Search subfolders in a project directory for folders without a pdb file."
echo "I have had some false positives. Check the results before doing anything rash."
echo "Usage: uf" 
find `pwd` -type d -name '*startphase*' | while read a ;
do if [ ! -f $a/*_****.pdb ]; 
then echo $a; 
fi;
done
}

function unfincnt {
if [ $# -lt 2 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage: unfincnt projectDirectory prefix1" 
  return 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Note add ^ in front of first argument when phrase is at the beginning of the line."
  echo "Usage: unfincnt projectDirectory prefix1" 
  return 2
fi
echo "Search subfolders in a project directory for folders without a pdb file and return the number of folders."
echo "I have had some false positives. Check the results before doing anything rash."
echo "Prefix1 is the stem of the pdb filename."
echo "Move to the directory just above the projectDirectory"
echo "Usage: unfincnt projectDirectory prefix1" 
find "./"$1 -mindepth 1 -maxdepth 2 -type d '!' -exec test -e "{}/"$2"_([1-9999]|****).pdb" ';' -print | wc -l
}

### V



### W

function whileLoop { 
FILE1=$1
echo "Runs script every 5 seconds for 10 times"
echo "Usage: whileLoop scriptfile"
echo "Example whileLoop quizDP2pdf.py"
echo "Blaine Mooers, Oct. 29, 2017"
COUNTER=0
while [  $COUNTER -lt 10 ]; do
    echo The counter is $COUNTER
    ./$FILE1
    sleep 5 
    let COUNTER=COUNTER+1 
done
}

### X


### Y


### Z

function zsh {
echo "Change the shell language of the terminal to zsh."
echo "Usage: zsh"
chsh -s /bin/zsh
}

