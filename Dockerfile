FROM alpine:latest
RUN apk update && apk upgrade

CMD [ "/bin/bash", 'echo Hello there!' ] 