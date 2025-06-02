# Copyright 2020 Adevinta

FROM --platform=$BUILDPLATFORM golang:1.24-alpine AS builder

ARG TARGETOS TARGETARCH

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -a -tags netgo -ldflags '-w' ./cmd/vulcan-crontinuous

FROM alpine:3.22

RUN apk add --no-cache --update gettext

WORKDIR /app
COPY --from=builder /app/vulcan-crontinuous .
COPY config.toml .
COPY run.sh .

CMD ["./run.sh"]
