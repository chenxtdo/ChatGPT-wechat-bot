FROM node:latest

WORKDIR /code
RUN npm install
ADD package.json package-lock.json /code/
ADD . /code
CMD npm run dev
