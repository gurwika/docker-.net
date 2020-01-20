FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# restore dependencies
COPY *.csproj ./
RUN dotnet restore

# copy files
COPY . ./
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
EXPOSE 8001

# build files
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "docker-.net.dll"]