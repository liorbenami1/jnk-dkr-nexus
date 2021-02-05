FROM alpine:latest
RUN apk update && apk upgrade

CMD [ "echo",'echo Hello there!' ] 