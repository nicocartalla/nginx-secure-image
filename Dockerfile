FROM nginx:1.21.3-alpine
# Fix Vulns CVE-2021-22945, CVE-2021-22946, CVE-2021-22947 and CVE-2021-40528
RUN apk update \
   && apk upgrade \
   && apk add "curl>=7.79.1-r0" "libgcrypt>=1.8.8-r1" "libcurl>=7.79.1-r0" \
   && rm -rf /var/cache/apk/*

# Add permissions to nginx user and remove default nginx config
RUN chmod -R o-rwx /etc/nginx \
    && chown -R nginx:nginx /usr/share/nginx \
    && chown -R nginx:nginx /var/log/nginx \
    && chown -R nginx:nginx /etc/nginx \
    && chown -R nginx:nginx  /var/cache/nginx \
    && touch /var/run/nginx.pid \
    && chown -R nginx:nginx /var/run/nginx.pid \
    && rm -rf /usr/share/nginx/html/*

USER nginx:nginx
