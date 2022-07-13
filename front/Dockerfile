FROM node:16.16.0-alpine3.16

ENV HOME=/front \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0

WORKDIR ${HOME}

COPY package.json ./
COPY package-lock.json ./

RUN npm install

EXPOSE 80