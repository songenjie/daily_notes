# !/bin/bash 

if [ "$#" = 2 ]
then 
    export SourceData=$1
    export DestData=$2
else
    echo "$#" error
    exit 1
fi

FindFile()
{
SourceFiles=(`ls $1 | awk '{printf"%s ",$1}'`)
DestFiles=(`ls $2 | awk '{printf"%s ",$1}'`)

for((k=0;k<${#SourceFiles[@]};k++))
do 
    for((l=0;l<${#DestFiles[@]};l++))
    do    
        if [ "${SourceFiles[k]}" = "${DestFiles[l]}" ]
        then
            if [ -f $1/${SourceFiles[k]} ]
            then 
                echo "same file $1/${SourceFiles[k]}   $2/${DestFiles[l]}" 
                echo "$1/${SourceFiles[k]} $2/${DestFiles[l]}" >> $ROOT/DiffRecord
            fi
        fi
    done
done

}

if [ -f $ROOT/DiffRecord ]
then
    \rm -rf $ROOT/DiffRecord
fi
touch $ROOT/DiffRecord

SourceDirs=(`cd $SourceData && find . -type d | sort | uniq | awk '{printf"%s ",$1}'`)
DestDirs=(`cd $DestData && find . -type d | sort | uniq |awk '{printf"%s ",$1}'`)

for((i=1;i<${#SourceDirs[@]};i++))
do
    for((j=1;j<${#DestDirs[@]};j++))
    do   
        if [ "${SourceDirs[i]}" = "${DestDirs[j]}" ]
        then
            FindFile $SourceData/${SourceDirs[i]} $DestData/${DestDirs[j]}
        fi
    done
done

