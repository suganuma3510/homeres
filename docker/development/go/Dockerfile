FROM golang:1.15-alpine

WORKDIR /go/src/github.com/suganuma3510/homeres
ADD ./server /go/src/github.com/suganuma3510/homeres

ENV CGO_ENABLED=0 \
    GO111MODULE=on
ENV PORT 3000

RUN apk update && \
    apk add --no-cache git && \
    go get github.com/go-sql-driver/mysql && \
    go get github.com/google/uuid && \
    go get github.com/gorilla/mux && \
    go get github.com/labstack/echo/... && \
    go get github.com/pilu/fresh

EXPOSE ${PORT}

CMD ["fresh"]