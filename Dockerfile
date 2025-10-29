FROM golang:1.24.2 AS builder

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download


COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /tracker
FROM scratch

COPY --from=builder /tracker /tracker
COPY tracker.db /tracker.db


WORKDIR /
ENTRYPOINT ["/tracker"]