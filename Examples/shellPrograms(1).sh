#Running Build-in Shell Commands
echo "Hi I am user: $USER"  
# the echo command displays whatever comes after it
# in this case Hi I am user:
# the $USER display the name of the current computer user


echo "I am running in this location: $PWD"
# the echo command displays whatever comes after it
# in this case I am running in this location:
# the $PWD display the current working directory


echo
# this echo command displays a new empty line


echo "Press Any Key To Continue"
# this echo command displays Press Any Key To Continue


# Reading the Input Port
read keyboard
# The read command reads any input from the default input port
# the standard input port is the keyboard
# The word keyboard (after read) means that we are creating a 
# new variable and we are calling it keyboard
# Any data that we enter on the keyboard will be assigned to keyboard


clear   # the clear command displays a new clean screen 



# Executing Build-in Shell Commands and 
# Assigning Value to the Variable
myname=`whoami`         #no spaces allowed
# myname is the creation of a new variable
# whoami is a shell command that tells us the name of the current user
# The ` command is called thick, when we surround a command with 
# ticks, as shown above, the command inside the ticks will execute and 
# the command value will be assign to the variable before it, in this
# case: myname. Make sure not to leave spaces in between.


# See detailed description of this section in DetailedExplanation below


# if and else command
if [ $myname = mr ]; then
        echo "Hi $myname Welcome to OS v0.0"
else
        echo "You must be root to run this script"
        #exit 1
fi



<< DetailedExplanation

  if [ $myname = mr ]; then
        In shell the if statement is surrounded by [] square brackets,              
        the ;  and the statement “then”. Inside the brackets we write a 
        logical statement.
         
        echo "Hi $myname Welcome to OS v0.0"
        Displays Hi, the value of the myname variable, and 
        Welcome to OS v0.0  
        the $ on $myname means display the value of the variable myname

  else
        the else statement executes when the if statement above fails
        echo "You must be root to run this script"
  fi
        In other languages the if statement is controlled with { and }, in 
        shell there is no beginning { and the ending } is replaced with fi
        which happens to be the if command backwards.
DetailedExplanation


echo
echo "Press Any Key To Continue"
read keyboard
# We explained this section of code three sections above



# While Loop
# Guess the number game.  Version 2.0

clear   # the clear command displays a new clean screen 


ANSWER=5      #no spaces allowed   #This is the correct answer

echo "Guess a number between 1 and 10. "

while read NUM   # endless while loop reading data into NUM
do  #this is the beginning of the while loop

        # if elif else commands
        # Validating the input...
        if [ $NUM -lt 1 ] || [ "$NUM" -gt 10 ]; then
               # -lt means less than   -gt means greater than
               # notice that the variable $NUM can be inside " " or not

              echo "The number must be between 1 and 10! Guess again. "

        elif [ $NUM -eq $ANSWER ]; then
               #elif means else if, -eq means equals
 
               echo "You got the answer correct!"
               break   # if elif if correct break terminates the while loop

        else
                echo "Incorrect, guess again. "
        fi

done  #this is the end of the while loop

echo
echo "Press Any Key To Continue"
read keyboard
# We explained this section of code several times above



clear   # the clear command displays a new clean screen 

COUNTER=0         #no spaces allowed, creating variable COUNTER                                      
                                 # and assigning the value of 0 to it


while true   # endless while loop
do                # while loop beginning
    sleep 1     # suspends processing for 1 milisecond

    COUNTER=`expr $COUNTER + 1`
    # the string   `expr $COUNTER + 1` is surrounded by ` (ticks)
    # it means that whatever is inside the ticks needs to be executed
    # in this case the command  expr  will process  $COUNTER + 1
    # as a mathematical expression, adding 1 to the value inside
    # $COUNTER

    echo "Program has been running for $COUNTER seconds..."

    if [  "$COUNTER" -gt 5  ]; then   #beginning of the if statement
             # if the value inside $COUNTER is greater than 5
             # it will execute the following break command which will
             # terminate the while loop, this is the only way to terminate
             # this while true loop
             break
    fi       # terminates the if statement

done # while loop ending


echo
echo "Press Any Key To Continue"
read keyboard
# We explained this section of code several times above


clear   # the clear command displays a new clean screen 



# for loops
# Validate numbers...

echo "Please enter a list of numbers between 1 and 100 leaving one space between the numbers. "
read NUMBERS
# We explained this section of code several times above
for NUM in $NUMBERS
       # this loop reads each value inside the $NUMBERS variable into the 
       # new NUM variable. The loop will continue until all values inside     
       # $NUMBERS are processed
do  #beginning of this for loop   
      if [ "$NUM" -lt 1 ] || [ "$NUM" -gt 100 ]; then
          #checks if the value in $NUM is less than 1  OR
          #if the value in $NUM is greater than 100 
	echo "Invalid Number ($NUM) - Must be between 1 and 100!"
           #if this is true dsplays previous line
      else
	echo "$NUM is valid." #displays $NUM value
      fi #end of if [ "$NUM" -lt 1 ] || [ "$NUM" -gt 100 ]; then

done  #ending of this for loop


echo
echo "Press Any Key To Continue"
read keyboard
# We explained this section of code several times above


clear   # the clear command displays a new clean screen 


#case statement
echo "Enter a number between 1 and 5. "
read CHOICE
#reads the default input device, placing value into CHOICE

case $CHOICE in

     #checks the $CHOICE value and selects corresponding number
     1) echo "You Selected 1" ;;
     2) echo "You Selected 2" ;;
     3) echo "You Selected 3" ;;
     4) echo "You Selected 4" ;;
     5) echo "You Selected 5" ;;
     *) echo "Invalid Entry" ;;
     #the ;; in each line terminates the case 

esac #end of  case $CHOICE in


echo
echo "Press Any Key To Continue"
read keyboard
# We explained this section of code several times above


clear   # the clear command displays a new clean screen 



#touch command
# Prompt for a user name...
echo "Please enter your name:"
read USERNAME

# Prompt for a user age...
echo "Hi $USERNAME, enter your age:"
read AGE

# create USERNAME.txt text data file
touch $USERNAME.txt

# insert AGE into $USERNAME.txt text file
echo $AGE > $USERNAME.txt

# files flags
# Check Flags
<<File
  These are the flags that are used
  on directories and files  
  -d  directory exists
  -f  file exists and is not a directory
  -r  file is readable
  -s  file exists and is not empty
  -w  file is writable
  -x  file is executable
File

#regular if 
if [ -s ${USERNAME}.txt ]; then
        # read the age from the file.
        # if the file exists and is not empty, see flags above
        AGE=`cat ${USERNAME}.txt`
        # assign the above commad to AGE

        echo "so ... you are $AGE years old!"
        #use the $AGE value above

else
        # Ask the user for his/her age
        echo "Hi $USERNAME, how old are you?"
        read AGE

fi #end if [ -s ${USERNAME}.txt ]; then


#nested if
if [ "$AGE" -le 2 ]; then
           # -le 2  is equal to  less or equal to 2
	echo "Hi $USERNAME, you are too young!"
else
	if [ "$AGE" -ge 100 ]; then
                # -ge 100  is equal to  geater or equal to 100
	      echo "Hi $USERNAME, You must be a wise person!"

	else
       	      echo "well let me will give you some advice"
       	      echo "Hi $USERNAME, now that you are $AGE be nice to 
                            the people you meet on your way up..."

           fi #end if [ "$AGE" -ge 100 ]; then
fi #end if [ "$AGE" -le 2 ]; then


echo
echo "Press Any Key To Continue"
read keyboard
# We explained this section of code several times above


clear   # the clear command displays a new clean screen 



# Soccer Game
# These variables hold the counters.
TEAM_ONE=0           #no spaces allowed
TEAM_TWO=0          #no spaces allowed
ERROR_MSG=""      #no spaces allowed

clear  # the clear command displays a new clean screen 

#Comparisons commands
<<C
  ==   equivalent, equal to
  !=   not equal 
  -eq  equal to
  -ne  not equal to
  -lt  less than
  -le  less than or equal to
  -gt  greater than
  -ge  greater than or equal to
C


while true
do
    # If choice not 1, 2 or 3, display error message
    if [ "$ERROR_MSG" != "" ]; then
        echo "Sorry  $ERROR_MSG"
        echo ""
    fi #end if [ "$ERROR_MSG" != "" ]; then

    # Write out the menu options...
    echo "Team One Goals = $TEAM_ONE"
    echo "Team One Goals = $TEAM_TWO"
    echo ""
    echo " Make Goal For"
    echo " 1] Team One"
    echo " 2] Team Two"
    echo " 3] End Game"
    
    ERROR_MSG="" #reset error message

    read CHOICE

    case $CHOICE in

        1) TEAM_ONE=`expr $TEAM_ONE + 1` ;;
        2) TEAM_TWO=`expr $TEAM_TWO + 1` ;;
        3) echo "See you at next game"; break ;;
        *) ERROR_MSG="Choose choice 1, 2 or 3" #During a case statment * mean defalut

    esac #end case $CHOICE in

    clear # the clear command displays a new clean screen 

done #end while true


echo
echo "Press Any Key To Continue"
read keyboard
# We explained this section of code several times above


clear   # the clear command displays a new clean screen 


myname=`whoami`   #no spaces allowed

VALID_PASSWORD="secret" #our password. no spaces allowed

echo "Please enter the password:"
read PASSWORD

if [ $PASSWORD = $VALID_PASSWORD ]; then
	echo "Welcome "  $myname  ", you have access!"
else
	echo "User or Password not correct, ACCESS DENIED!"
fi #if [ $PASSWORD = $VALID_PASSWORD ]; then


#head
echo
echo "Select any filename above to display the first 5 records"
read FILENAME
echo
echo "Printing head -5 of $FILENAME"
head -5 $FILENAME
# head displays the first 5 lines of code inside the $FILENAME file


echo
echo "Press Any Key To Continue"
read keyboard
echo 
# We explained this section of code several times above


clear   # the clear command displays a new clean screen 


#tail
echo "Now printing the last 3 records in $FILENAME:"
tail -3 $FILENAME 
# tail displays the last 3 lines of code inside the $FILENAME file


