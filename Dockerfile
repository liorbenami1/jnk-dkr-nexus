FROM alpine:latest
RUN apk update && apk upgrade

RUN echo Hello there!