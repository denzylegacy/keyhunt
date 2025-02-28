FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git build-essential libssl-dev libgmp-dev

WORKDIR /app

COPY ./app .

RUN make

CMD ["./keyhunt", "-m", "bsgs", "-f", "tests/140.txt", "-b", "140", "-t", "4", "-s", "10", "-R"]