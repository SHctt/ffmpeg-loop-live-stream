#Dockerfile
FROM jrottenberg/ffmpeg

WORKDIR /ffmpeg

COPY ./stream.sh /

RUN chmod +x /stream.sh

ENTRYPOINT ["/stream.sh"]