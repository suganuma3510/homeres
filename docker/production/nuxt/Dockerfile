FROM node:12.18.3-alpine3.12

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo

ENV HOST 0.0.0.0
ENV PORT 8080

WORKDIR /app
ADD . /app

RUN apk update && \
    apk upgrade && \
    npm install -g n && \
    yarn install && \
    rm -rf /var/cache/apk/*

EXPOSE ${PORT}

CMD ["yarn", "dev"]
