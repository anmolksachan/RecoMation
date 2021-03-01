#$ sudo chmod +x response.sh
#$ ./response.sh alive.txt
#we will catch all the response headers and response bodies of the subdomains stored in alive.txt

#!/bin/bashmkdir headers
mkdir responsebodyCURRENT_PATH=$(pwd)for x in $(cat $1)
do
        NAME=$(echo $x | awk -F/ '{print $3}')
        curl -X GET -H "X-Forwarded-For: evil.com" $x -I > "$CURRENT_PATH/headers/$NAME"
        curl -s -X GET -H "X-Forwarded-For: evil.com" -L $x > "$CURRENT_PATH/responsebody/$NAME"
done
