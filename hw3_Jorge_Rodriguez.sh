# bash hw3_jorge_rodriguez.sh https://www.gutenberg.org/files/58785/58785-0.txt
echo "----------------------------"
echo "URL: $1"
echo "----------------------------"

if [ $# -ne 1 ]
   then
       echo "Please provide a txt file url"
       echo "usage ./calculate_basic_stats.sh  url"
       #exit with error
       exit 1
fi   

echo "============> Question 1 <======================"
echo  "############### Statistics for file  ############### "
echo "URL: $1"
echo  "############### Statistics for file  ############### "
echo "============> END Question 1 <======================"
echo " "
echo " "

echo "============> Question 2 <======================"
sorted_words_book=`curl -s $1`
echo $sorted_words_book > "sorted_words_book.txt"

sorted_words_before=`curl -s $1|tr [A-Z] [a-z]|grep -oE "\w+"|sort|uniq -c|sort `
echo $sorted_words_before > "sorted_words_before.txt"

sorted_words=`curl -s $1|tr [A-Z] [a-z]|grep -oE "\w+"|sort|uniq -c|sort -k1,1 -k2,2r`
# echo $sorted_words > "sorted_words.txt"

total_uniq_words=`echo "$sorted_words"|wc -l`
echo "Total number of Unique words = $total_uniq_words"

#total_uniq_words="echo "$sorted_words"|wc -l"
#echo "Total number of unique words = $total_uniq_words"

echo "============> END Question 2 <======================"
echo " "
echo " "

echo "============> Question 3 <======================"
echo "Min frequency and word  $(echo "$sorted_words"| head -n 1)"
echo "Max frequency and word  $(echo "$sorted_words"| tail -n 1)"
echo "============> END Question 3 <======================"
echo " "
echo " "


echo "============> Question 4 <======================"
median1 = echo "sort -n sorted_words.txt | awk '{a[NR]=$1} END {if (NR%2==0) print (a[NR/2]+a[NR/2 + 1]); print(a[NR])}'"
#median1="500"
echo "The Median is: $median1"
echo "============> END Question 4 <======================"
echo " "
echo " "


echo "============> Question 5, 6 and 7 <======================"

file_name_path="sorted_words.txt"
awk 'BEGIN{c=0} //{c++} END{print "Number of words: ",c/2}' RS="[[:space:]]" $file_name_path

for value in $(echo "$sorted_words"); do
#  echo "the value is $(echo "$value")"
  if [[ $value =~ [0-9]+ ]]
    then
      #echo "the value is $(echo "$value")"
      total_freq=$(($total_freq + $value))
      #echo "the Total Freq is $(echo "$total_freq")"
    fi
  if [[ $value =~ [a-z]+ ]]
    then
      #echo "the value is $(echo "$value")"
      count=$(($count + 1))
      #echo "the Total Count is $(echo "$count")"
    fi
done
mean=$((total_freq/count))
echo "the total number of words is $(echo "$count")"
echo "the total number of frequency is $(echo "$total_freq")"
echo "the Mean is $(echo "$mean")"

echo "============> END Question 5, 6 and 7 <======================"
echo " "
echo " "


echo "============> Question 8 <======================"
echo "the Mean is $(echo "$mean" | bc -l)"
awk -v a=$total_freq -v b=$count 'BEGIN{print a/b}'
echo " "
echo " "
echo "============> END Question 8 <======================"

echo "============> Question 9 <======================"
function lazy_commit() {
  echo "This is Question 9"
  for var in "$@"
  do
    echo "$var"
    echo "Arguments:$var"
    echo "git add $var"
    git add "$var"
  done
  git commit -m "This is Automation Lazy"
  git push origin master
}

lazy_commit hw3_Jorge_Rodriguez.sh jorge1 jorge2 jorge3

echo " "
echo " "
echo "============> END Question 9 <======================"



echo "******************** END ***********************"

