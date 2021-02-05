FROM alpine:latest
RUN apk update && apk upgrade

CMD [ "/bin/sh", '-c','echo Hello there!' ] 