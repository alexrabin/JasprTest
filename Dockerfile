FROM ghcr.io/cirruslabs/flutter:stable AS build

RUN touch /.dockerenv

# Setup Tailwind CSS
RUN curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64
RUN chmod +x tailwindcss-linux-x64
RUN mv tailwindcss-linux-x64 /usr/local/bin/tailwindcss


WORKDIR /app
COPY . .

# Resolve app dependencies.

RUN rm -f pubspec_overrides.yaml
RUN dart pub get
RUN dart pub global activate jaspr_cli

# Build project
RUN dart pub global run jaspr_cli:jaspr build --verbose

# This is additionally needed for the runtime libs.
FROM dart:stable AS dart

FROM scratch

COPY --from=dart /runtime/ /
COPY --from=build /app/build/jaspr/ /app/

WORKDIR /app

# Start server.
EXPOSE 8080
CMD ["./app"]