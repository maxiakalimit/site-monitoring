FROM dart:3.0.3

ARG BOT_TOKEN
ARG CHAT_ID
ARG DELAY_SECONDS
ARG PATH_URLS

ENV CHAT_ID $CHAT_ID
ENV BOT_TOKEN $BOT_TOKEN
ENV DELAY_SECONDS $DELAY_SECONDS

WORKDIR /app
# Copy app source code
COPY . .
COPY ${PATH_URLS} bin/file.txt
RUN dart pub get

RUN dart compile exe bin/site_monitoring.dart -o bin/serve

#CMD /app/bin/server --path="bin/file.txt" --token=${BOT_TOKEN} --chatId=${CHAT_ID}
CMD dart run bin/site_monitoring.dart --path="bin/file.txt" --token=${BOT_TOKEN} --chatId=${CHAT_ID}
