from elixir:1.16-slim

ENV APP_DIR /app

RUN apt update -y && apt upgrade -y && \
    apt install curl -y && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt install gcc g++ make nodejs inotify-tools postgresql-client locales -y

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir $APP_DIR

COPY . $APP_DIR

WORKDIR $APP_DIR

RUN mix local.hex --force && \
    mix archive.install --force hex phx_new && \
    mix local.rebar --force && \
    mix deps.get --force

WORKDIR assets

WORKDIR $APP_DIR

EXPOSE 4000

CMD ["mix", "phx.server"]

