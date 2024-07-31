FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app
COPY . .

ENV NODE_VERSION=20.13.1
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

RUN npm i

COPY . .

# Setup Tailwind CSS
RUN curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64
RUN chmod +x tailwindcss-linux-x64
RUN mv tailwindcss-linux-x64 /usr/local/bin/tailwindcss

# Resolve app dependencies.
RUN rm -f pubspec_overrides.yaml

# Must build the app as a non root user.
RUN useradd -ms /bin/bash developer

RUN chown -R developer:developer /usr/local/bin
RUN chmod 755 /usr/local/bin
RUN chown -R developer:developer /app
RUN chmod 755 /app

RUN chown -R developer:developer /sdks/flutter
RUN chmod 755 /sdks/flutter

USER developer

# Must run flutter doctor to download the web sdk.
RUN flutter doctor -v

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
