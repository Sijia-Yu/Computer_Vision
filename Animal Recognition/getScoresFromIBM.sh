echo "Begins! Do once!"

testFile1="/Users/apple/Desktop/CV/Result/test1.txt"
testFile2="/Users/apple/Desktop/CV/Result/negative1.txt"

#--------LOOP：Read each line of "test1.txt",curl json, get Score from txt file--------------
#creat a folder for one animals 100 tests
temp="/Users/apple/Desktop/CV/Result/PositiveTest1"
mkdir $temp
temp2="/Users/apple/Desktop/CV/Result/NegativeTest1"
mkdir $temp2

i=1
while read testline
do
	#creat a txt store one test score
	oneScore="${temp}""/tmp""${i}"".txt"

	curl -X POST -H "Accept-Language: en" -F "images_file=@${testline}"  -F "threshold=0.0"  -F "parameters=@test.json" "https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify?&api_key={"8a1694ccaa48db9e7591320fb89116282bbc38f5"}&version=2016-05-20" 1>$oneScore

	#get Score for one test
	scoreFile="/Users/apple/Desktop/CV/Result/PositiveScores.txt"
	T_NUM=$(awk 'NR==10 {print $2}' $oneScore)
	echo $T_NUM >> $scoreFile
	#end

	i=`expr $i + 1`
	sleep 5s
done < $testFile1
#----------------------------------end---------------------------------------

j=1
while read negativeline
do
	#creat a txt store one test score
	oneScore2="${temp2}""/tmp""${j}"".txt"

	curl -X POST -H "Accept-Language: en" -F "images_file=@${negativeline}"  -F "threshold=0.0"  -F "parameters=@test.json" "https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify?&api_key={"8a1694ccaa48db9e7591320fb89116282bbc38f5"}&version=2016-05-20" 1>$oneScore2

	#get Score for one test
	scoreFile="/Users/apple/Desktop/CV/Result/NegativeScores.txt"
	T_NUM=$(awk 'NR==10 {print $2}' $oneScore2)
	echo $T_NUM >> $scoreFile
	#end

	j=`expr $j + 1`
	sleep 5s
done < $testFile2