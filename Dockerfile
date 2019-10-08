FROM python:3.7.4-alpine3.9

# Install build dependencies
RUN apk --update add --virtual build-dependencies build-base openssl-dev libffi-dev && \
    pip install --upgrade pip cffi

# Install ansible
RUN pip install ansible

# Clear out dependencies
RUN apk del build-dependencies build-base openssl-dev libffi-dev && \
    rm -rf /var/cache/apk/*

CMD [ "ansible-playbook", "--version" ]