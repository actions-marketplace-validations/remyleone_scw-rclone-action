FROM alpine

ENV RCLONE_VERSION='1.53.3-r1'

RUN apk add rclone=${RCLONE_VERSION}

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "--help" ]
