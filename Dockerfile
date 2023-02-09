FROM node:19 AS app
WORKDIR /code
ADD package.json package-lock.json /code/
RUN npm install
# We don't need the standalone Chromium
RUN apt-get install -y wget \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get -y install google-chrome-stable chromium  xvfb\
    && rm -rf /var/lib/apt/lists/* \
    && echo "Chrome: " && google-chrome --version

ADD . /code
ENV WECHATY_PUPPET_WECHAT_ENDPOINT=/usr/bin/google-chrome
CMD npm run dev
