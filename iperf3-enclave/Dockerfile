FROM golang:1.21 as builder

# Unset CGO_ENABLED to get a statically-linked binary. This is necessary because
# the golang image uses libc while alpine uses libmusl.
RUN CGO_ENABLED=0 go install github.com/Amnesic-Systems/nitriding@latest
RUN cp $GOPATH/bin/nitriding /

FROM alpine

RUN apk add --update --no-cache iperf3

COPY --from=builder /nitriding /bin/
COPY /start.sh /bin/

CMD ["start.sh"]
