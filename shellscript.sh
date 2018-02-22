#!/bin/bash

#Creating a directory if it doesnt exist already
mkdir -p -- "user_records"

#index for the loop condition, set default value to 1
loopindex=1

#variable to prevent the loop  to iterate over and over again when an error occurs
#will be used in an if statement as long as a parameter check
#default value is 1
ifFlag=1

#while loop that keeps iterating untill the user gives the correct input
while [[ loopindex -eq 1 ]]; do
	#statements

	#if no parameters are added the go to interactive mode
	if [ $# == 0 ] || [[ ifFlag -eq 0 ]]
		then
		#Interactive mode
		#Ask the user for input
		echo What is your name?
		read tempName

		#check if the input is empty
		if [ -z "$tempName" ]
			then
			echo ERROR: The name input was empty/blank.
			echo Please insert your data again.
			#skip the rest of the loop iteration
			continue
		fi

		#removing the double quotes
		nameInput="${tempName%\"}"
		nameInput="${nameInput#\"}"

		#Ask the user for their username
		echo What is your chosen username?
		read textFileName

		#check if the input is empty
		if [ -z "$textFileName" ]
			then
			echo ERROR: The user name input was empty/blank.
			echo Please insert your data again.
			#skip the rest of the loop iteration
			continue
		fi

		#check if the file already exists
		if [ -f ~/user_records/$textFileName.txt ]
			then
			echo ERROR: Invalid UserName. File already exists.
			echo Please insert your data again.
			#skip the rest of the loop iteration
			continue
		fi

		#get the date and the time
		dateNow=$(date +"%d/%m/%Y")
		timeNow=$(date +"%T")

		#variable that hold data in a single string for the file
		fullStamp=$dateNow:$timeNow

		#append all the information to a file
		echo $nameInput >>~/user_records/$textFileName.txt
		echo $textFileName>>~/user_records/$textFileName.txt
		echo $fullStamp >>~/user_records/$textFileName.txt

		#display to the user a success message
		echo Your file has been created and is in ~/user_records/
		echo It is named $textFileName.txt

		#deleting variable content
		dateNow=""
		timeNow=""
		nameInput=""
		textFileName=""
		fullStamp=""
		tempName=""
		break

	#end of the interactive mode
	fi

	#check if there is a second parameter
	if [ "$2" == "" ]
		then
		echo ERROR: There is no second parameter.

		#change the ifflag value because we want the if statement to run 
		#but we have more than 0 parameters so this will make it run [ $# == 0 ] || [[ ifFlag -eq 0 ]]
		ifFlag=0

		echo Starting the interactive mode.

		#skip the rest of the loop iteration
		continue

	#check if there is more than 2 parameters
	elif [ $# -gt 2 ] 
		then
	    echo ERROR: No more than two parameters are accepted.

	    #change the ifflag value because we want the if statement to run
	    #on the start of the interactive mode 
	    ifFlag=0

	  	echo Starting the interactive mode.

	  	#skip the rest of the loop iteration
	  	continue

	#Non interactive mode
	else 
		nameInput=$1
		textFileName=$2

		#check if the file already exists
		if [ -f ~/user_records/$textFileName.txt ]
			then
			echo ERROR: Invalid UserName. File already exists.

			#change the ifflag value because we want the if statement to run 
			#on the start of the interactive mode
			ifFlag=0

			echo Starting the interactive mode.

			#skip the rest of the loop iteration
			continue
		fi

		#get the date and the time
		dateNow=$(date +"%d/%m/%Y")
		timeNow=$(date +"%T")

		#variable that hold data in a single string for the file
		fullStamp=$dateNow:$timeNow

		#append all the data to a file
		echo $nameInput >>~/user_records/$textFileName.txt
		echo $textFileName>>~/user_records/$textFileName.txt
		echo $fullStamp >>~/user_records/$textFileName.txt

		#display to the user a success message
		echo Your file has been created and is in ~/user_records/
		echo It is named $textFileName.txt

		#deleting variable content
		dateNow=""
		timeNow=""
		nameInput=""
		textFileName=""
		fullStamp=""
		tempName=""
		loopindex=""
		ifFlag=""
		
	#end of the Non interactive mode
	fi

	#break command to stop the loop
	break

done

#exit the program
exit
