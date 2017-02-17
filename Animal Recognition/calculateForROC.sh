positivePath="/Users/apple/Desktop/CV/calculateROC/OpossumPositive.txt"
negativePath="/Users/apple/Desktop/CV/calculateROC/OpossumNegative.txt"

threshold=0
while [ $(echo "$threshold <= 1" | bc) = 1 ]
do
	count=0
	tprFile="/Users/apple/Desktop/CV/CI/""${threshold}""tprFile.txt"
	fprFile="/Users/apple/Desktop/CV/CI/""${threshold}""fprFile.txt"

	while(( $count < 50 ))
	do
		i=1
		fn=0
		tp=0
		# tprFile="/Users/apple/Desktop/calculateROC/tprFile.txt"
		while(( $i<=10 ))
		do
			tmp=`expr $count \* 10`
			line=`expr $i + $tmp`
			num=$(sed -n "${line}p" $positivePath)

			if [[ $(echo "$num >= $threshold" | bc) -eq 1 ]];then
				tp=`expr $tp + 1`
			fi

			i=`expr $i + 1`
		done
		echo $tp
		tpr=$(printf "%.6f" `echo "scale=6; $tp / 10" | bc`)
		echo $tpr >> $tprFile

		j=1
		tn=0
		fp=0
		# fprFile="/Users/apple/Desktop/calculateROC/fprFile.txt"
		while(( $j<=10 ))
		do
			tmp=`expr $count \* 10`
			line=`expr $j + $tmp`
			num=$(sed -n "${line}p" $negativePath)
			
			if [[ $(echo "$num >= $threshold" | bc) -eq 1 ]];then
				fp=`expr $fp + 1`
			fi

			j=`expr $j + 1`
		done
		echo $fp
		fpr=$(printf "%.6f" `echo "scale=6; $fp / 10" | bc`)
		echo $fpr >> $fprFile

		count=`expr $count + 1`
	done

	threshold=$(printf "%.2f" `echo "scale=2; $threshold + 0.05" | bc`)
done
