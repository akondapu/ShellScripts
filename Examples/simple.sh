echo "
**************************************************
Author: Joseph Martinez
Course: CGS3767 OS
Professor: Michael Robinson
Program: PGM 3, Shell Executable
Due Date: 10/25/2017

I certify that this work is my own alone. 
**************************************************
"

myname=`whoami`
echo "a) Hello my name is: $myname"
echo "b) My user name is: $USER"
date=`date`
echo "c) Todays date and time is: $date"

filelines=`cat martinezJpgm3.sh | wc -l`
echo "d) This file has $filelines lines"

filewords=`cat martinezJpgm3.sh | wc -w`
echo "e) This file has $filewords words"

filebytes=`cat martinezJpgm3.sh | wc -c`
echo "f) This file has $filebytes bytes"

echo "g) Please enter a number"
read number

num=$((number*2))

echo "h) Your number $number * 2 = $num"
echo "i) STOP, waiting for the user to press ANY KEY"
read keyboard
echo "j) Diplay a new clean screen"
clear

echo "k) Enter a line of numbers to be added"
read NUMBERS

SUM=0
for NUM in $NUMBERS
    do
        sleep 1;
        printf  "%d " $NUM;
        SUM=$(($SUM + $NUM));
done
printf "%s %s\n" = $SUM;

while true
do
echo "m) Enter a number that get 0 for mod 5"
read number
remainder=$(($number % 5))

    if [ "$remainder" -eq 0 ]; then
        echo "Good Job!"; break
    elif [ "$remainder" -ge 0 ] || [ "$remainder" -lt 0 ]; then
        echo "Try again...remainder = $remainder"
    fi
done
