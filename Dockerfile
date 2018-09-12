FROM golang:alpine

# Get library requirements.
RUN apk update && apk add make git build-base curl autoconf automake libtool docker

# Get C++ protobuf library.
RUN git clone https://github.com/google/protobuf -b v3.6.1 --depth 1

# Install C++ protobuf library.
RUN cd protobuf && ./autogen.sh && ./configure && make && make install && cd .. && rm -rf protobuf

# Install golang protobuf generator.
RUN go get -u github.com/golang/protobuf/protoc-gen-go