FROM python:3.8.6-alpine3.12

RUN apk add --no-cache curl jq bash py-pip redis git openssh-client
RUN sed -i -e 's/v[[:digit:]]\..*\//edge\//g' /etc/apk/repositories
RUN apk add --no-cache jo
RUN pip install jinja2 pyyaml redis jsonpath-ng requests ruamel.yaml

RUN LATEST_YQ_TAG=`curl --silent "https://api.github.com/repos/mikefarah/yq/releases/latest" | grep '"tag_name":' | sed -e 's/^.*"tag_name": "\([^"]*\)".*$/\1/'` && \
    curl --silent -o /bin/yq -L "https://github.com/mikefarah/yq/releases/download/$LATEST_YQ_TAG/yq_linux_amd64" && \
    chmod 755 /bin/yq 

RUN bash --version
RUN jq --version
RUN curl --version
RUN yq --version
RUN jo -v
RUN python --version
RUN redis-cli -v
RUN git --version
RUN ssh -V

CMD ["/bin/bash"]
