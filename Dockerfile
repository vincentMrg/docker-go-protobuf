FROM golang:alpine

MAINTAINER Vincent Marguerie "vmarguerie@gmail.com"

# Get library requirements.
RUN apk update && apk add make git build-base curl autoconf automake libtool docker bash \
                                                                                 && curl -sL https://get.docker.com/builds/Linux/x86_64/docker-1.8.1 > /usr/bin/docker \
                                                                                 && chmod +x /usr/bin/docker \
                                                                                 && curl -sL https://github.com/docker/docker/raw/master/hack/dind > /usr/local/bin/dind \
                                                                                 && chmod +x /usr/local/bin/dind

# Get C++ protobuf library.
RUN git clone https://github.com/google/protobuf -b v3.6.1 --depth 1

# Install C++ protobuf library.
RUN cd protobuf && ./autogen.sh && ./configure && make && make install && cd .. && rm -rf protobuf

# Install golang protobuf generator.
RUN go get -u github.com/golang/protobuf/protoc-gen-go


VOLUME /var/lib/docker
CMD ["dind", "docker", "daemon"]