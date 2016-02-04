echo Enter file name
read fname
while read line
do
    for word in $line
    do
        echo "word = '$word'"
    done
done < $fname
