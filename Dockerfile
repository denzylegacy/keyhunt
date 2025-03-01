FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git build-essential libssl-dev libgmp-dev

RUN useradd -m -s /bin/bash appuser

WORKDIR /app

COPY ./app .

RUN make

RUN chown -R appuser:appuser /app

RUN su appuser -c "echo '#!/bin/bash' > run_keyhunt.sh" && \
    su appuser -c "echo 'while true; do' >> run_keyhunt.sh" && \
    su appuser -c "echo '  timeout 30m ./keyhunt -m bsgs -f tests/140.txt -b 140 -t 4 -s 10 -R' >> run_keyhunt.sh" && \
    su appuser -c "echo '  sleep 10m' >> run_keyhunt.sh" && \
    su appuser -c "echo 'done' >> run_keyhunt.sh"

RUN chmod +x run_keyhunt.sh

USER appuser

CMD ["./run_keyhunt.sh"]
