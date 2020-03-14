FROM cm2network/steamcmd AS download
RUN /home/steam/steamcmd/steamcmd.sh +login anonymous +@sSteamCmdForcePlatformType windows +force_install_dir /home/steam/groundbranch +app_update 476400 +quit

FROM alpine:latest
WORKDIR /groundbranch
COPY --from=download /home/steam/groundbranch .
COPY steam_appid.txt .
RUN apk add --no-cache ca-certificates freetype gnutls wine wine_gecko
EXPOSE 7777/udp
EXPOSE 27015/udp
ENTRYPOINT ["wine64", "GroundBranchServer.exe"]
