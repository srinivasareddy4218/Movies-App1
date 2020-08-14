FROM node

COPY /backend/package.json .
RUN yarn install

COPY /backend/server.js .
COPY /backend/movies-model.js .

EXPOSE 4000

CMD node server.js prod
