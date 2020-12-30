FROM node:12.18.3-alpine3.12

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo

ENV HOST 0.0.0.0
ENV PORT 80

WORKDIR /app

COPY package*.json /app
COPY . /app

RUN yarn install

RUN yarn run build

EXPOSE ${PORT}

CMD ["yarn", "start"]
