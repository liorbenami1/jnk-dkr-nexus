FROM alpine:latest
RUN apk update && apk upgrade

ENTRYPOINT ["echo",'Hello there!'] 