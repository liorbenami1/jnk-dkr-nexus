FROM alpine:latest
RUN apk update && apk upgrade

CMD [ "sh", 'echo Hello there!' ] 