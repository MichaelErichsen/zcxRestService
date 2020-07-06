docker buildx build --force-rm -t zcxrestservice:dev  --platform linux/s390x --tag zcxrestservice:dev --tag zcxrestservice:s390x --tag zcxrestservice:latest --load .
if %errorlevel% neq 0 exit /b %errorlevel%
docker save -o c:\Temp\zcxrestservice.tar zcxrestservice
docker load --input c:\Temp\zcxrestservice.tar
docker image ls
docker ps -a
docker run -P --name zcxrestservice zcxrestservice 