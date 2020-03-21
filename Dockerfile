FROM cm2network/steamcmd AS download
RUN /home/steam/steamcmd/steamcmd.sh +login anonymous +@sSteamCmdForcePlatformType windows +force_install_dir /home/steam/groundbranch +app_update 476400 +quit

FROM debian:sid-slim
WORKDIR /groundbranch
COPY --from=download /home/steam/groundbranch .

# Install latest Wine Staging with vcruntime140_1.dll support
RUN apt-get update && \
	apt install -y wget gnupg2 && \
	wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
	apt-key add winehq.key && rm winehq.key && \
	echo deb 'https://dl.winehq.org/wine-builds/debian/ buster main' > /etc/apt/sources.list.d/wine.list && \
	dpkg --add-architecture i386 && \
	apt update && \
	apt install -y winehq-staging && \
	rm -rf /var/lib/apt/lists/*

COPY steam_appid.txt .
COPY start.sh .

ENV WINEDEBUG=fixme-all
EXPOSE 7777/udp
EXPOSE 27015/udp
ENTRYPOINT ["/groundbranch/start.sh"]
