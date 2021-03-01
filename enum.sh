#How to run
#sudo chmod +X enum.sh #setting file permissions
#./enum.sh anmolksachan.com
#├── alive.json
#├── alive.txt
#├── domains.json
#├── domains.txt
#└── enum.sh0 directories, 5 files

#--------------#

##!/bin/bash
#starting sublist3r
sublist3r -d $1 -v -o domains.txt

#running assetfinder
~/go/bin/assetfinder --subs-only $1 | tee -a domains.txt

#removing duplicate entries
sort -u domains.txt -o domains.txt

#checking for alive domains
echo "\n\n[+] Checking for alive domains..\n"
cat domains.txt | ~/go/bin/httprobe | tee -a alive.txt

#formatting the data to json
cat alive.txt | python -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > alive.json

cat domains.txt | python -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > domains.json
