#FROM debian:buster AS tools

#RUN apt-get update && apt-get install -y \
#	git \
#	curl \
#	jq

#FROM apache/airflow

#COPY --from=tools /usr/lib /usr/lib
#COPY --from=tools /usr/bin /usr/bin
#COPY --from=tools /usr/share /usr/share
#WORKDIR /opt/airflow
#RUN ["/bin/bash", "-c", "mkdir data && cd data && while read i; do git clone $i; done < <(curl -s https://api.github.com/orgs/datasets/repos?per_page=100 | jq -r '.[].clone_url')"]

FROM python:latest

WORKDIR /ihm

COPY requirements.txt /ihm
COPY main.py /ihm

CMD ["python", "-m pip install --upgrade pip"]

RUN pip install -r requirements.txt

CMD ["python", "main.py"]

#ENTRYPOINT ["/bin/sh", "-c"]