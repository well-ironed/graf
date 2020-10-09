FROM centos:8

ARG ERLANG_VSN=23.1
ARG ELIXIR_VSN=1.10.4-otp-23
ARG NODEJS_VSN=14.13.0

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_CTYPE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=dumb

RUN yum -y update && \
    yum install -y autoconf automake git gcc make ncurses-devel openssl-devel \
         glibc-langpack-en unzip

RUN yum install -y epel-release && \
    yum repolist && \
    yum install -y inotify-tools

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0 && \
    . $HOME/.asdf/asdf.sh && \
    asdf plugin add erlang && \
    asdf plugin add elixir && \
    asdf plugin add nodejs && \
    ~/.asdf/plugins/nodejs/bin/import-release-team-keyring && \
    asdf install erlang $ERLANG_VSN && \
    asdf install elixir $ELIXIR_VSN && \
    asdf install nodejs $NODEJS_VSN && \
    asdf global erlang $ERLANG_VSN && \
    asdf global elixir $ELIXIR_VSN && \
    asdf global nodejs $NODEJS_VSN

RUN echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc

RUN /bin/bash --login -c "mix local.hex --force && mix local.rebar --force"

COPY . /graf

RUN /bin/bash --login -c "cd /graf && make compile"

WORKDIR /graf
ENTRYPOINT ["./priv/generate.sh"]
