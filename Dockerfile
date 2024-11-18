ARG BASE_IMAGE
ARG BUILDER_IMAGE

FROM $BUILDER_IMAGE AS builder
WORKDIR /go/src/kubernetes-csi/livenessprobe
ADD . .
ENV GOTOOLCHAIN auto
ENV GOFLAGS="-buildvcs=false"
RUN make build

FROM $BASE_IMAGE
LABEL maintainers="Compute"
LABEL description="CSI Driver Liveness Probe"
ARG binary=./bin/livenessprobe

COPY --from=builder /go/src/kubernetes-csi/livenessprobe/${binary} /livenessprobe
ENTRYPOINT ["/livenessprobe"]
