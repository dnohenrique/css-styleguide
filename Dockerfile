FROM node:10 AS css-styleguide
WORKDIR /workdir

COPY ./package*.json ./
RUN npm install

COPY ./ ./
RUN npm run build

FROM nginx:1.19-alpine
COPY ./default.conf /etc/nginx/conf.d/
COPY --from=css-styleguide /workdir/dist/. /usr/share/nginx/html/
