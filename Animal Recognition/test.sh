for((var=1;var<=3;var++)); do
	echo "Begins! Do once!"
	#var=1
	#var=`expr $var + 1`

	#----------Read one “train.txt” file--------------
	trainPath="/Users/apple/Desktop/CV/Opossumtrain/train"
	trainFile="${trainPath}""${var}"".txt"
	echo $trainFile
	#---------------end----------------------

	#--------Read each line of "train1.txt", copy the image to the folder，zip it---------
	trainDir="/Users/apple/Desktop/CV/OpossumtrainImgs"
	mkdir $trainDir

	while read line
	do
		cp $line $trainDir
	done < $trainFile

	zip -r OpossumtrainImgs.zip OpossumtrainImgs
	#---------------------------end--------------------------------------


	#--------Read each line of "nagative1.txt", copy the image to the folder，zip it---------
	#---------------------------end----------------------------------------

	#-------------curl POST classifier------------------
	#curl -X POST -F "Opossum_positive_examples=@OpossumtrainImgs.zip" -F "negative_examples=@negativeImgs.zip" -F "name=Opossum" "https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classifiers?api_key={8a1694ccaa48db9e7591320fb89116282bbc38f5}&version=2016-05-20"
	#--------------------end--------------------------

	#----------Read one "test.txt" file--------------
	testPath="/Users/apple/Desktop/CV/Opossumtest/test"
	testFile="${testPath}""${var}"".txt"
	#--------------------end------------------------

	#--------LOOP：Read each line of "test1.txt",curl json, get Score from txt file--------------
	#creat a folder for one animals 100 tests
	temp="/Users/apple/Desktop/CV/OpossumScore/Test""${var}"
	mkdir $temp

	i=1
	while read testline
	do
		#creat a txt store one test score
		oneScore="${temp}""/tmp""${i}"".txt"

		curl -X POST -H "Accept-Language: en" -F "images_file=@${testline}"  -F "threshold=0.0"  -F "parameters=@test.json" "https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify?&api_key={"8a1694ccaa48db9e7591320fb89116282bbc38f5"}&version=2016-05-20" 1>$oneScore

		#get Score for one test
		scoreFile="/Users/apple/Desktop/CV/OpossumScore/Scores""${var}"".txt"
		T_NUM=$(awk 'NR==10 {print $2}' $oneScore)
		echo $T_NUM >> $scoreFile
		#end

		i=`expr $i + 1`
		sleep 3s
	done < $testFile
	#----------------------------------end---------------------------------------

done
