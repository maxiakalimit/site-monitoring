FROM dart:3.0.3

ENV BOT_TOKEN $BOT_TOKEN
ENV CHAT_ID $CHAT_ID
ENV DELAY_SECONDS $DELAY_SECONDS
ENV PATH_URLS $PATH_URLS

WORKDIR /app
# Copy app source code
COPY . .
RUN dart pub get

RUN dart compile exe bin/site_monitoring.dart -o bin/server

RUN /app/bin/server --delay=${DELAY_SECONDS} --path=${PATH_URLS} --token=${BOT_TOKEN} --chatId=${CHAT_ID}
