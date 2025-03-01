FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git build-essential libssl-dev libgmp-dev lm-sensors

RUN useradd -m -s /bin/bash appuser

WORKDIR /app

COPY ./app .
COPY run.sh .

RUN make

RUN chown -R appuser:appuser /app

RUN chmod +x run.sh

USER appuser

CMD ["./run.sh"]
