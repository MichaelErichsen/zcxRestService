docker buildx build --force-rm -t zcxrestservice:dev --tag zcxrestservice:dev --tag zcxrestservice:latest --load .
rem docker buildx build --force-rm -t zcxrestservice:dev  --platform linux/s390x --tag zcxrestservice:dev --tag zcxrestservice:s390x --tag zcxrestservice:latest --load .
if %errorlevel% neq 0 exit /b %errorlevel%
docker save -o C:\Users\michael\Documents\IBM\zCX\zcxrestservice.tar zcxrestservice
dir C:\Users\michael\Documents\IBM\zCX\zcxrestservice.tar
docker load --input c:\Temp\zcxrestservice.tar
docker image ls
docker ps -a
docker run -P --name zcxrestservice zcxrestservice 
call "C:\Users\michael\Documents\IBM\zCX\untar.cmd"