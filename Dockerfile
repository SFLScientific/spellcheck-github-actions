FROM python:3.7

LABEL "repository"="https://github.com/UnicornGlobal/spellcheck-github-actions"
LABEL "homepage"="https://github.com/actions"

RUN apt-get update && apt-get install -y \
    aspell \
 && rm -rf /var/lib/apt/lists/*
RUN pip3 install pyspelling
COPY entrypoint.sh /entrypoint.sh
COPY spellcheck.yaml /spellcheck.yaml
COPY wordlist.txt /wordlist.txt
ENTRYPOINT ["/entrypoint.sh"]
