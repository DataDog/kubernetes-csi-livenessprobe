ARG BASE_IMAGE

FROM golang:1.20 as builder
WORKDIR /go/src/kubernetes-csi/livenessprobe
ADD . .
ENV GOFLAGS="-buildvcs=false"
RUN make build

FROM $BASE_IMAGE
LABEL maintainers="Compute"
LABEL description="CSI Driver Liveness Probe"
ARG binary=./bin/livenessprobe

COPY --from=builder /go/src/kubernetes-csi/livenessprobe/${binary} /livenessprobe
ENTRYPOINT ["/livenessprobe"]
