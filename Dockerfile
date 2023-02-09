FROM --platform=linux/amd64 node:19 AS app
WORKDIR /code
# We don't need the standalone Chromium
RUN apt-get install -y wget
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update && apt-get -y install google-chrome-stable
RUN rm -rf /var/lib/apt/lists/*
RUN echo "Chrome: " && google-chrome --version
ADD package.json package-lock.json /code/
RUN npm install
ADD . /code
ENV WECHATY_PUPPET_WECHAT_ENDPOINT=/usr/bin/google-chrome
CMD npm run dev
