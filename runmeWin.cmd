docker buildx build --force-rm -t zcxrestservice:dev --tag zcxrestservice:dev --tag zcxrestservice:latest --load .
rem docker buildx build --force-rm -t zcxrestservice:dev  --platform linux/s390x --tag zcxrestservice:dev --tag zcxrestservice:s390x --tag zcxrestservice:latest --load .
if %errorlevel% neq 0 exit /b %errorlevel%
docker save -o c:\Temp\zcxrestservice.tar zcxrestservice
dir c:\Temp\zcxrestservice.tar
docker load --input c:\Temp\zcxrestservice.tar
docker image ls
docker ps -a
docker run -P --name zcxrestservice zcxrestservice 
"C:\Program Files\7-Zip\7z.exe" x -oc:\Temp\zcxrestservice\ -y -aoa c:\Temp\zcxrestservice.tar
FOR /R "c:\Temp\zcxrestservice\" %%I IN (*.tar) DO "C:\Program Files\7-Zip\7z.exe" -aou -o"c:\Temp\zcxrestservice\" x "%%I"