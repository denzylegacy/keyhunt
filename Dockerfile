FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git build-essential libssl-dev libgmp-dev

WORKDIR /app

COPY . .

RUN ls -la

RUN make

CMD ["./keyhunt", "-m", "bsgs", "-f", "tests/125.txt", "-b", "125", "-q", "-s", "10", "-R"]