#获得压缩包
	
var=2
#----------Read one “train.txt” file--------------
trainPath="/Users/apple/Desktop/Opossumtrain/train"
trainFile="${trainPath}""${var}"".txt"
echo $trainFile
#---------------end----------------------

#--------Read each line of "train1.txt", copy the image to the folder，zip it---------
trainDir="/Users/apple/Desktop/Classifier/OpossumPositiveTrainImgs"
mkdir $trainDir

while read line
do
	cp $line $trainDir
done < $trainFile

zip -r OpossumPositiveTrainImgs.zip OpossumPositiveTrainImgs
#---------------------------end--------------------------------------
