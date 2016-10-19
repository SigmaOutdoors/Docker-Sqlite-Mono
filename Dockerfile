FROM alpine:latest
#COPY ./dep/* /usr/bin/
RUN apk update
RUN apk add musl
RUN apk add ncurses-libs
RUN apk add ncurses-terminfo-base
RUN apk add ncurses-terminfo
RUN apk add pkgconf
RUN apk add readline
RUN apk add sqlite-libs
RUN apk add sqlite
#CMD ["/bin/ls", "/usr/bin"]
ENTRYPOINT ["tail", "-f", "/dev/null"]
