FROM debian:buster AS tools

RUN apt-get update && apt-get install -y \
	git \
	curl \
	jq	

# RUN apt-get update && \
#     apt-get install -y curl \
#     wget \
#     openjdk-11-jdk
# ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/jre/bin/java

FROM apache/airflow
COPY --from=tools /usr/lib /usr/lib
COPY --from=tools /usr/bin /usr/bin
COPY --from=tools /usr/share /usr/share


#WORKDIR /opt/airflow

RUN ["/bin/bash", "-c", "mkdir data && cd data && while read i; do git clone $i; done < <(curl -s https://api.github.com/orgs/datasets/repos?per_page=100 | jq -r '.[].clone_url')"] 
CMD ["/bin/python"]
COPY . /opt/airflow
RUN pip install -r requirements.txt
# RUN export JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"

# ENTRYPOINT ["bash"]
