echo "Enter name of file to check:"
read fname

#Check if dictionary file exists yet
if [ ! -f CABSC.dict ]
then
    echo "" > CABSC.dict
fi

#Read file line by line
while read line
do
    #Read each word on line
    for word in $line
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
                $word >> CABSC.dict
            fi
        fi
    done
done < $fname
