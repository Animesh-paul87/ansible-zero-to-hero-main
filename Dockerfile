FROM alpine:latest
RUN apk add --no-cache openssh ansible openssh-client\
    && ssh-keygen -A \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#UsePAM no/UsePAM no/' /etc/ssh/sshd_config \
    && echo "root:password123456789" | chpasswd 
    
COPY entrypoint.sh /entrypoint.sh
RUN ls -l /
RUN chmod +x /entrypoint.sh


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
