#!/bin/bash
  2 #CS2600 Project 3
  3 #scriptname: phonebook.bash
  4 #author: Kevin Wong
  5 echo "Please enter the phonebook file name: "
  6 read phonebook #reads phonebook file name
  7 file=$phonebook
  8 #file assigned to $phonebook so cat can redirect content to file called temp.txt
  9
 10 cat $file > temp.txt
 11
 12 temp=temp.txt
 13 while [ TRUE ] #prompts menu and continues to reprompt the menu while the while loop remains true
 14 do
 15     echo "1.) List of records in First Name (alphabetical order)"
 16     echo "2.) List of records in Last Name (alphabetical order)"
 17     echo "3.) List of records in reverse First Name (alphabetical order)"
 18     echo "4.) List of records in reverse Last Name (alphabetical order)"
 19     echo "5.) Search for a record by Last Name"
 20     echo "6.) Search for a record by Birthday"
 21     echo "7.) Insert Record"
 22     echo "8.) Delete Record"
 23     echo "9.) Exit program"
 24     echo "Please choose an option from 1 to 9"
 25     read i #reads menu input
 26
 27     if [ $i == 1 ]
 28     then
 29         clear
 30         sort $file > $temp #sorts and transfers into temp file
 31         cat $temp #displays the dumped file, the contents of temp.txt
 32         echo " "
 33         echo "Press Enter in order to continue"
 34         read x
 35     elif [ $i == 2 ]
 36     then
 37         clear
 38         sort -k 2 $file > $temp #sorts by the contents of the second field and dumps everything into the temporary file
 39         cat $temp #displays sorted dumped file
 40         echo " "
 41         echo "Press Enter in order to continue"
 42         read x
 43     elif [ $i == 3 ]
 44     then
 45         clear
 46         sort -r $file #displays reversely sorted file
 47         sort -r $file > $temp #sorts in reverse order first, then dumps all contents into text file
 48         echo " "
 49         echo "Press Enter in order to continue"
 50         read x
 51     elif [ $i == 4 ]
 52     then
 53         clear
 54         sort -r -k 2 $file > $temp #sorts by contents of the second field in reverse then transfers it to the temporary file
 55         cat $temp #displays the contents of temporary file
 56         echo " "
 57         echo "Press Enter in order to continue"
 58         read x
 59     elif [ $i == 5 ]
 60     then
 61         clear
 62         echo "Enter Last Name of record that you want to search for: "
 63	    read ln #reads user input
 64         clear
 65         awk -v var="$ln" -F'[ :]' '$0 ~ var {print $0}' $file #searches for last name ln that was entered by the user
 66         echo " "
 67         echo "Press Enter to continue"
 68         read x
 69     elif [ $i == 6 ]
 70     then
 71         clear
 72         echo "Enter Birthday (MM/DD/YY) of record that you want to search for: "
 73         read bday
 74         clear
 75         awk -v var="$bday" -F'[ :]' '$0 ~ var {print $0}' $file #searches for birthday bday that was entered by the user
 76         echo " "
 77         echo "Press Enter to continue"
 78         read x
 79     elif [ $i == 7 ]
 80     then
 81         clear
 82         echo "Enter the First and Last Name (Capitalize First and Last Name) of the record that you want to insert: "
 83         read fl
 84         echo "Enter the Phone Number(###-###-####) of the record that you want to insert: "
 85         read pn
 86         pnNumberCount=${#pn}
 87         if [ $pnNumberCount == 12 ] #checks if phone number has the correct amount of characters
 88         then
 89             echo "Enter Address and Street: "
 90             read addy
 91             echo "Enter City: "
 92             read city
 93             echo "Enter State Initials and ZIP: "
 94             read sizip
 95             echo "Enter Birthday (MM/DD/YY): "
 96             read bday
 97             echo $fl":"$pn":"$pn":"$addy","$city","$sizip":"$bday >> $temp #adds the given content into the temporary file
 98             sort $temp #sorts temporary file to correctly place inserted record
 99             echo " "
100             echo "Press Enter to continue"
101             read x
102         else
103             echo "Incorrect phone number format. Press Enter and try again."
104         fi
105     elif [ $i == 8 ]
106     then
107         clear
108         echo "Enter the Last Name or Phone Number of record to be deleted: "
109         read delete
110         clear
111         sed "/$delete/d" $file > $temp #deletes user-specified record then transfers it all to temporary file
112         cat $temp
113         echo " "
114         echo "Press Enter to continue"
115         read x
116     elif [ $i == 9 ]
117     then
118         cat $temp > $file #transfers contents of temporary phonebook file into the actual phonebook/datebook file
119         break
120     fi
121 done
