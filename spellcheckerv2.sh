#!/bin/bash
echo "Enter name of file to check: "
read fname

# Make array to hold words
words=()

#Check if dictionary file exists yet
if [ ! -f CABSC.dict ]
then
        echo "" > CABSC.dict
fi

#Read file line by line
while read line
do
        #read each word on line
        for word in $line
        do
                words+=("$word")
        done
done < $fname

for word in ${words[@]}
do
        if ! grep $word "CABSC.dict" > /dev/null
        then
                echo $word is not in dictionary
                echo "Would you like to add it? <y/n>"
                read ans
                while [ $ans != "y" -a $ans != "n" ]
                do
                        echo y or n only
                        read ans
                done
                if test $ans == "y"
                then
                        echo $word >> CABSC.dict
                fi
                echo "Would you like to change the spelling of the word? <y/n>"
                read ans
                while [ $ans != "y" -a $ans != "n" ]
                do
                        echo y or n only
                        read ans
                done
                if test $ans == "y"
                then
                        echo "What is the new spelling?"
                        read new_word
                        ed = $fname <<!
                        g/$word/s//$new_word/g
                        w
                        q
                        !
                fi
        fi
done
