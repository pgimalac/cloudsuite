FROM cloudsuite/base-os:debian

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends nginx \
  && rm -rf /var/lib/apt/lists/*

# Increase the open file limit
COPY files/limits.conf.append /tmp/
RUN cat /tmp/limits.conf.append >> /etc/security/limits.conf

COPY files/nginx.location.append /tmp/
RUN cat /tmp/nginx.location.append > /etc/nginx/sites-available/default

COPY files/HTMLWebPlayer /usr/share/nginx/html/HTMLWebPlayer

# Update nginx to serve /videos
#RUN sed -i 's|/usr/share/nginx/html|/videos|g' /etc/nginx/sites-available/default

RUN apt -y update \
    && apt install -y strace
RUN which strace

CMD ["strace", "-f", "-ttt", "-T", "-o strace.out", "nginx", "-g", "daemon off;"]
