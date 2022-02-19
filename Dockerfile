FROM dahlgren/depotdownloader AS download
RUN dotnet /depotdownloader/DepotDownloader.dll -os windows -dir /groundbranch -app 476400

FROM debian:bookworm-slim
WORKDIR /groundbranch
COPY --from=download /groundbranch .

RUN dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install -y curl gnupg2 && \
	echo "deb https://dl.winehq.org/wine-builds/debian/ bookworm main" > /etc/apt/sources.list.d/winehq.list && \
	curl "https://dl.winehq.org/wine-builds/winehq.key" | apt-key add - && \
	apt-get update && \
	apt-get install -y winehq-stable && \
	rm -rf /var/lib/apt/lists/*

COPY steam_appid.txt .
COPY start.sh .

ENV WINEDEBUG=fixme-all
EXPOSE 7777/udp
EXPOSE 27015/udp
ENTRYPOINT ["/groundbranch/start.sh"]
