#Better be on the edge, because mono is on the egde branch
FROM alpine:edge
#COPY ./dep/* /usr/bin/
#RUN apk update

# Oh and another thing, mono is in the testing respository, you'll get a message all day long 
# ERROR: unsatisfiable constraints:
#  mono (missing):
#    required by: world[mono]
# The command '/bin/sh -c apk --verbose add mono' returned a non-zero code: 1
# So you have to add the testing repo to your /etc/apk/repositories file so it can find mono

RUN echo 'http://dl-4.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories

# Get all the dependencies for sqlite

RUN apk add --update --progress --no-cache  musl ncurses-libs ncurses-terminfo-base ncurses-terminfo \
pkgconf \
sqlite-libs \
sqlite 

# Get all the dependencies for mono

RUN apk add --update --progress --no-cache  zlib libbz2 libressl2.4-libcrypto \
expat libffi gdbm ncurses-libs readline libressl2.4-libssl python2

#install mono

RUN apk --verbose --update add mono

COPY ./hello-world.cs /usr/bin/

#CMD ["/bin/ls", "/usr/bin"]
ENTRYPOINT ["tail", "-f", "/dev/null"]
