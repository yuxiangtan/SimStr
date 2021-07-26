#in the Est output folder.

#put all the abund.txt files into a single folder
mkdir abund_prof_merge
count_num=0
for file in `find . -name abund.txt`
do
let count_num=count_num+1
newfile="abund_prof_merge/profile_"$count_num".txt"
cp $file $newfile
#echo $newfile
done

#run merge_Est.R to merge all profile files into one matrix.
Rscript ./merge_Est.R