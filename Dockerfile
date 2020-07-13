FROM mono AS base
#FROM mcr.microsoft.com/dotnet/core/aspnet:2.1-stretch-slim AS base
WORKDIR /app
EXPOSE 80

FROM mono AS build
#FROM mcr.microsoft.com/dotnet/core/sdk:2.1-stretch AS build
WORKDIR /src
COPY ["zcxRestService.csproj", ""]
#RUN dotnet restore "./zcxRestService.csproj"
RUN nuget restore "zcxRestService.csproj"
COPY . .
WORKDIR "/src/."
#RUN dotnet build "zcxRestService.csproj" -c Release -o /app/build
RUN msbuild /p:Configuration=Release "zcxRestService.csproj"
CMD ["mono", "/app/build/zcxRestService.exe"]

#FROM build AS publish
#RUN dotnet publish "zcxRestService.csproj" -c Release -o /app/publish
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "zcxRestService.dll"]