#LMD : 2016-10-20
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
# cat /etc/apk/repositories to see what's already there

RUN echo 'http://dl-4.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories

# install all the dependencies for sqlite

RUN apk add --update --progress --no-cache  musl ncurses-libs ncurses-terminfo-base ncurses-terminfo \
pkgconf \
sqlite-libs \
sqlite 

# install all the dependencies for mono

RUN apk add --update --progress --no-cache  zlib libbz2 libressl2.4-libcrypto \
expat libffi gdbm ncurses-libs readline libressl2.4-libssl python2 nginx=1.10.2-r0


# RUN  apk add --update nginx=1.10.1-r9

# needs this for ps file that's in /etc/init.d/nginx or it won't start
RUN mkdir -p /run/nginx
RUN mkdir -p /usr/share/nginx/html

COPY ./dep/index.html /usr/share/nginx/html
COPY ./dep/nginx.conf /etc/nginx/nginx.conf
COPY ./dep/nginx.vh.default.conf /etc/nginx/conf.d/default.conf
COPY ./dep/container-startup.sh /usr/bin/container-startup.sh
RUN chmod 777 /usr/bin/container-startup.sh

# Check that nginx is running : 
#       http://localhost:8080/


EXPOSE 80

#Install mono and clean up cache files we don't need

RUN apk --verbose --update add mono && \
rm -rf /var/cache/apk/*

COPY ./dep/hello-world.cs /usr/bin/

#Run mono test inside container
#   cd /usr/bin
#   mcs hello-world.cs
#   mono hello-world.exe

ENTRYPOINT ["/usr/bin/container-startup.sh"]
