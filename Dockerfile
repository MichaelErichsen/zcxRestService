FROM clefos/mono:latest as base
WORKDIR /app
EXPOSE 80
RUN mkdir /app/publish

FROM base as build
WORKDIR /src
COPY ["zcxRestService.csproj", ""]
COPY . .
#RUN nuget restore -verbosity detailed
WORKDIR "/src/."
RUN xbuild /p:Configuration=Release 

#FROM build AS publish
#RUN msbuild /p:configuration=Release

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
CMD ["mono", "./zcxRestService.exe"]