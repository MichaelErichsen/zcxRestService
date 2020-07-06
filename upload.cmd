scp -P 8022 c:/Temp/zcxrestservice.tar michael@192.168.10.199:/tmp/zcxrestservice.tar
ssh michael@192.168.10.199 -p 8022
echo docker load --input zcxrestservice.tar
echo docker image ls
echo docker tag zcxrestservice:s390x zcxrestservice:latest
echo docker run -p 8080:80 -d zcxrestservice
