#FROM debian:buster AS tools

#RUN apt-get update && apt-get install -y \
#	git \
#	curl \
#	jq

FROM python:latest

#FROM apache/airflow

#COPY --from=tools /usr/lib /usr/lib
#COPY --from=tools /usr/bin /usr/bin
#COPY --from=tools /usr/share /usr/share

#WORKDIR /opt/airflow
WORKDIR /ihm

#RUN ["/bin/bash", "-c", "mkdir data && cd data && while read i; do git clone $i; done < <(curl -s https://api.github.com/orgs/datasets/repos?per_page=100 | jq -r '.[].clone_url')"]
COPY requirements.txt /ihm
COPY main.py /ihm

RUN pip install -r requirements.txt
#CMD ["/usr/bin/python3.7", "main.py"]
ENTRYPOINT ["bash"]
