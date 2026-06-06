from elixir:1.18-slim

ENV APP_DIR /app

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install curl -y
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
RUN apt-get install gcc g++ make nodejs inotify-tools postgresql-client locales -y

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir $APP_DIR

COPY . $APP_DIR

WORKDIR $APP_DIR

RUN mix local.hex --force
RUN mix archive.install --force hex phx_new
RUN mix local.rebar --force
RUN mix deps.get --force

WORKDIR assets

WORKDIR $APP_DIR

EXPOSE 4000

CMD ["mix", "phx.server"]

