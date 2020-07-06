FROM clefos/mono:latest as base
ADD . /src
EXPOSE 80
RUN xbuild --verbosity:diagnostic --filelogger zcxRestService.sln
CMD ["mono", "/src/zcxRestService/bin/Debug/zcxRestService.exe"]

#FROM mcr.microsoft.com/dotnet/core/aspnet:2.1-stretch-slim AS base
#WORKDIR /app
#EXPOSE 80
#
#FROM clefos/mono:latest AS build
#WORKDIR /src
#COPY ["zcxRestService.csproj", ""]
#RUN dotnet restore "./zcxRestService.csproj"
#COPY . .
#WORKDIR "/src/."
#RUN dotnet build "zcxRestService.csproj" -c Release -o /app/build
#
#FROM build AS publish
#RUN dotnet publish "zcxRestService.csproj" -c Release -o /app/publish
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "zcxRestService.dll"]