FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS builder

RUN apk add libcurl

WORKDIR /source
COPY . .

VOLUME /out

CMD dotnet --list-sdks \
    && dotnet build -c Release NBitcoin || true \
    && dotnet pack --no-build -c Release -o /out/packages NBitcoin \
    && dotnet build -c Release NBitcoin.Altcoins || true \
    && dotnet pack --no-build -c Release -o /out/packages NBitcoin.Altcoins
