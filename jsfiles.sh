#$ chmod 755 jsfiles.sh
#$ ./jsfiles.sh
# collect all the JavaScript files from the response body text which we collected in response.sh

#!/bin/bashmkdir scripts
mkdir scriptsresponseRED='\033[0;31m'
NC='\033[0m'
CUR_PATH=$(pwd)for x in $(ls "$CUR_PATH/responsebody")
do
        printf "\n\n${RED}$x${NC}\n\n"
        END_POINTS=$(cat "$CUR_PATH/responsebody/$x" | grep -Eoi "src=\"[^>]+></script>" | cut -d '"' -f 2)
        for end_point in $END_POINTS
        do
                len=$(echo $end_point | grep "http" | wc -c)
                mkdir "scriptsresponse/$x/"
                URL=$end_point
                if [ $len == 0 ]
                then
                        URL="https://$x$end_point"
                fi
                file=$(basename $end_point)
                curl -X GET $URL -L > "scriptsresponse/$x/$file"
                echo $URL >> "scripts/$x"
        done
done
