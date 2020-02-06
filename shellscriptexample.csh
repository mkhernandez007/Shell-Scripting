#!/bin/csh
#=============================================================================#
# An introduction to C Shell (csh), which is quite similar to the T C Shell
# (tcsh), but not the Bourne Shell (bsh), the Bourne Again Shell (bash), or the
# Kourn Shell (ksh).
#=============================================================================#
# Date: 11/12/08
# Version: 1.0.0
# Executing:
# csh shellscriptexample.csh
#=============================================================================#
#
## The print command is "echo"
#

echo "Hi there!"

#
## Send the echo's into a file. x >a means redirect the output x to a. While
## x >> a allows you to append to the file without overwriting it.
#

echo "Hi there!" > CaptureFile.txt
echo "This class is Meteo 473" >> CaptureFile.txt

#
## Print out your computer environement.
#

# env

#
## Paths are what your executables lookfor in order to run.
#

echo $shell
echo $path

#
## While loops are the equivalent of the FORTRAN90 DO loops. @ sets up the
## counters, ++ is short hand for $count = $count + 1.
#

@ count = 1
while ($count <= 10)
   echo "COUNT: $count"
   @ count ++
end

#
## If loops. Touch if the file doesn't exist it will create the file, if it
## exists it will update the time stamp.
#

@ count = 1
while ($count <= 10)
   echo "COUNT: $count"
   if ($count < 10) then
      echo $count > datafile.0$count.dat
   else if ($count < 100) then
      touch datafile.$count.dat
      echo $count > datafile.$count.dat
   else
      echo "nothing to do"
   endif
   @ count ++
end

#
## List all files into a variable file.
#

set files = `ls /home/meteo/mkh182/Example_9/data*.dat`

#
## For each is another loop.
#

@ count = 1
clear
foreach processfile ($files)
   echo "Processing File $count == $processfile"

#
## If you find this pattern return all contents in each file.
### grep -e "--cut here--" will look for the exact string "--cut here--",
### without it, it will try to parse the sting and look for "--cut" and
### "here--".
#

   grep -n -e "$count" $processfile
   @ count ++
end

#
## To get the arguemtns from the command line prompt.
#

set numarguments = $#argv
if ($numarguments >0) then
   echo "Number of command ine arguments: $numarguments"
   @ iargs = 1
   while ($iargs <= $numarguments)
      echo "Argument $iargs == $argv[$iargs]"
      @ iargs ++
   end
endif

#
## To compile from a c shell.
#

set dirExample = /home/meteo/mkh182/Example_9
set GRIBdir = /home/meteo/mkh182/473projects
set LIBGRIB = /terra/s0/cloth/meteo473/w3lib-1.6/lib/libw3.a

cd $GRIBdir
pwd

source /terra/s0/cloth/meteo473/w3lib-1.6/docs/GRIB.PathSetup.txt
pgf90 -o ascii2grib ascii2grib.f $LIBGRIB
ls -l ascii2grib
cd $dirExample
pwd

#=============================================================================#
# End of scripting program
#=============================================================================#