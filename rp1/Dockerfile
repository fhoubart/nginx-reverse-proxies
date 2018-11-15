FROM nginx
COPY default.conf /etc/nginx/conf.d
RUN mkdir /etc/nginx/certs/
COPY gencert.sh /root/gencert.sh
RUN apt-get update
RUN apt-get install openssl
RUN /root/gencert.sh
EXPOSE 8000
