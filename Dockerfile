FROM node
COPY /frontend/package.json .
RUN  npm install

COPY /frontend/src/server.js .

EXPOSE 4040

CMD node server.js
