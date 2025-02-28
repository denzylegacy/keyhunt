FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git build-essential libssl-dev libgmp-dev

WORKDIR /app

COPY ./app .

RUN ls -la

RUN make

CMD ["./keyhunt", "-m", "bsgs", "-f", "tests/140.txt", "-b", "140", "-t", "8", "-s", "10", "-R"]