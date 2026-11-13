FROM alpine:latest
RUN apk add --no-cache openssh ansible openssh-client \
    && ssh-keygen -A \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && echo "root:usepasswordhere" | chpasswd \
    && : > /etc/motd \
    && apk add --no-cache py3-pip \
    && mkdir -p /ansible \
    && ansible-galaxy collection install community.proxmox --force \
    && pip3 install --no-cache-dir --break-system-packages proxmoxer requests \
    && apk del py3-pip
WORKDIR /ansible

    
# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
