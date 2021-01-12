FROM golang:1.15-alpine as builder

WORKDIR /go/src/github.com/suganuma3510/homeres

ENV GO111MODULE=on

COPY ../../server/go.mod ./server/go.sum ./
RUN go mod download

COPY ../../server ./

RUN CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
    go build -ldflags="-w -s" -o /go/bin/app

FROM alpine:latest

ARG gurunavi_api_key
ENV GURUNAVI_API_KEY=$gurunavi_api_key

RUN apk --no-cache add ca-certificates

COPY --from=builder /go/bin/app /go/bin/app

EXPOSE 3000

ENTRYPOINT [ "/go/bin/app" ]