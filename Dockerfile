FROM nginx:alpine

RUN apk add --no-cache --virtual unzip
ADD https://releases.hashicorp.com/consul-template/0.14.0/consul-template_0.14.0_linux_amd64.zip /usr/bin/
RUN unzip /usr/bin/consul-template_0.14.0_linux_amd64.zip -d /usr/local/bin

COPY files/s* /bin/
RUN chmod +x /bin/switch /bin/start.sh
COPY files/default.ctmpl /templates/

ENV LIVE blue
ENV BLUE_NAME blue
ENV GREEN_NAME green

EXPOSE 80 8080
ENTRYPOINT ["/bin/start.sh"]