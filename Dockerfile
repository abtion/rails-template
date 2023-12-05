FROM debian:bookworm

# Install build deps
RUN apt update;\
  apt install -y\
  git\
  curl\
  build-essential\
  libreadline6-dev\
  zlib1g-dev\
  chromium-driver\
  xvfb\
  libpq-dev\
  libyaml-dev\
  byobu

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1 && \
  echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
ARG CAPYBARA_NO_SANDBOX=1
ENV CAPYBARA_NO_SANDBOX=$CAPYBARA_NO_SANDBOX

# Make it easy to keep the container alive, yet comply when the container is asked to stop
RUN echo '#!/bin/bash' > wait-for-sigterm.sh \
  && echo 'trap "exit 0" SIGTERM' >> wait-for-sigterm.sh \
  && echo 'while true; do sleep 2; done' >> wait-for-sigterm.sh
RUN chmod +x wait-for-sigterm.sh

# Switch to correct work dir
WORKDIR /app

# ASDF
ENV PATH=$PATH:/root/.asdf/shims:/root/.asdf/bin
COPY .tool-versions ./
RUN asdf plugin add nodejs
RUN asdf plugin add ruby

VOLUME [ "/root/.asdf" ]
