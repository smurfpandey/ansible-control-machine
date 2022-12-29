FROM python:3.7.4-alpine3.9

# Install runtime dependencies
RUN apk add --update --no-cache openssh sshpass

# Install build dependencies
RUN apk --update add --virtual build-dependencies build-base openssl-dev libffi-dev && \
    pip install --upgrade pip cffi

# Install ansible
RUN pip install ansible==7.1.0
RUN pip install ansible-core==2.12.3


# Clear out dependencies
RUN apk del build-dependencies build-base openssl-dev libffi-dev && \
    rm -rf /var/cache/apk/*

# Setup runtime environment
RUN mkdir -p /ansible/playbooks
WORKDIR /ansible/playbooks

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh

ENTRYPOINT ["/bin/docker-entrypoint.sh"]
