FROM golang:latest as builder
WORKDIR /src/github.com/devinotelecom/prometheus-vmware-exporter
COPY ./ /src/github.com/devinotelecom/prometheus-vmware-exporter
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s"

FROM scratch
COPY --from=builder /src/github.com/devinotelecom/prometheus-vmware-exporter/prometheus-vmware-exporter /usr/bin/prometheus-vmware-exporter
EXPOSE 9512
ENTRYPOINT ["prometheus-vmware-exporter"]
