FROM clefos/mono:latest 
ADD . /home/david/sieve
RUN mcs /home/david/sieve/sieve.cs
CMD [ "mono", "/home/david/sieve/sieve.exe" ]