FROM mcr.microsoft.com/dotnet/core/sdk:2.1.505-alpine3.7 AS builder

RUN apk add libcurl

WORKDIR /source
COPY . .

VOLUME /out

CMD dotnet build /p:TargetFrameworkOverride=netstandard2.0 -c Release || true \
    && dotnet pack /p:TargetFrameworkOverride=netstandard2.0 --no-build -c Release -o /out/packages
