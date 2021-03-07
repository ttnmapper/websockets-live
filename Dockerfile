FROM golang:latest as builder

WORKDIR /go-modules

COPY . ./

# Building using -mod=vendor, which will utilize the v
#RUN go get
#RUN go mod vendor
RUN CGO_ENABLED=0 GOOS=linux go build -v -mod=vendor -o websockets-live

#FROM alpine:3.8
FROM scratch

WORKDIR /root/

COPY --from=builder /go-modules/websockets-live .
COPY conf.json .

CMD ["./websockets-live"]