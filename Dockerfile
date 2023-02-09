FROM node:latest

WORKDIR /code
ADD package.json package-lock.json /code/
RUN npm install
ADD . /code
CMD npm run dev
