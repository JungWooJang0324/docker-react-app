# ----------------- builder stage -------------------------
FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

# ----------------- run stage -------------------------

# nginx를 위한 베이스 이미지
FROM nginx

# build파일들을 /usr/share/nginx/html 부분으로 복사해줍니다.
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
