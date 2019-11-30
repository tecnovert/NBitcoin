FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic AS builder

RUN apt update && apt install -y libcurl3 libgit2-dev

WORKDIR /source
COPY . .

VOLUME /out

CMD dotnet --list-sdks \
    && dotnet build -c Release /p:TargetFrameworkOverride=netstandard2.0 -f netstandard2.0 NBitcoin || true \
    && dotnet pack --no-build /p:TargetFrameworkOverride=netstandard2.0 -c Release -o /out/packages NBitcoin \
    && dotnet build -c Release /p:TargetFrameworkOverride=netstandard2.0 -f netstandard2.0 NBitcoin.Altcoins || true \
    && dotnet pack --no-build /p:TargetFrameworkOverride=netstandard2.0 -c Release -o /out/packages NBitcoin.Altcoins
