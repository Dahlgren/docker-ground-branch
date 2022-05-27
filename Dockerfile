FROM cm2network/steamcmd AS download
RUN /home/steam/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir /home/steam/groundbranch +login anonymous +app_update 476400 +quit

FROM debian:bookworm-slim
WORKDIR /groundbranch
COPY --from=download /home/steam/groundbranch .

RUN apt-get update && \
	apt-get install -y ca-certificates gnupg2 wine64 && \
	rm -rf /var/lib/apt/lists/*

COPY steam_appid.txt .
COPY start.sh .

ENV WINEDEBUG=fixme-all
EXPOSE 7777/udp
EXPOSE 27015/udp
ENTRYPOINT ["/groundbranch/start.sh"]
