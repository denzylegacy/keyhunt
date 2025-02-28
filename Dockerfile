FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git build-essential libssl-dev libgmp-dev

RUN useradd -m -s /bin/bash appuser

WORKDIR /app

COPY ./app .

RUN make

RUN chown -R appuser:appuser /app

USER appuser

CMD ["./keyhunt", "-m", "bsgs", "-f", "tests/140.txt", "-b", "140", "-t", "4", "-s", "10", "-R"]
