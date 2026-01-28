FROM ghcr.io/puppeteer/puppeteer:24.34.0

# Install fonts
USER root
RUN apt-get update && apt-get install -y \
    fonts-inter \
    fonts-roboto \
    fonts-noto \
    fonts-noto-extra \
    fonts-noto-color-emoji \
    && rm -rf /var/lib/apt/lists/*

USER $PPTRUSER_UID
ARG NODE_ENV=production

WORKDIR /service

COPY package.json /service/package.json
COPY yarn.lock /service/yarn.lock

RUN yarn install --frozen-lockfile;

# Copy app source
COPY . .

# set your port
ENV PORT=2305

# expose the port to outside world
EXPOSE 2305

# start command as per package.json
CMD ["node", "src/index"]