FROM ghcr.io/home-assistant/home-assistant:stable

# כתובות להורדה מה-Release:
ENV NETFREE_TAR_URL="https://github.com/Mordechay0000/netfree-python/releases/download/v1.0.0/netfree-python.tar.gz"
ENV NETFREE_SHA_URL="https://github.com/Mordechay0000/netfree-python/releases/download/v1.0.0/netfree-python.tar.gz.sha256"

# הורדה של שני הקבצים ואימות ה־SHA256
RUN set -eux; \
    mkdir -p /tmp/netfree_dl; \
    cd /tmp/netfree_dl; \
    # הורדת הארכיון
    wget --no-check-certificate -O netfree-python.tar.gz "$NETFREE_TAR_URL"; \
    # הורדת קובץ ה-SHA256
    wget --no-check-certificate -O netfree-python.tar.gz.sha256 "$NETFREE_SHA_URL"; \
    # בדיקת תקינות מול ה־sha שהורד
    sha256sum -c netfree-python.tar.gz.sha256; \
    # חילוץ
    tar -xzf netfree-python.tar.gz -C /tmp; \
    # העתקת הקבצים
    cp -a /tmp/netfree-python/opt/openssl-3.0.2 /opt/openssl-3.0.2; \
    cp /tmp/netfree-python/_ssl.cpython-313-aarch64-linux-musl.so \
       /usr/local/lib/python3.13/lib-dynload/_ssl.cpython-313-aarch64-linux-musl.so; \
    # הרשאות
    chmod -R 755 /opt/openssl-3.0.2; \
    chmod 755 /usr/local/lib/python3.13/lib-dynload/_ssl.cpython-313-aarch64-linux-musl.so; \
    # ניקיון זמני
    rm -rf /tmp/netfree_dl /tmp/netfree-python

# Python wrapper – שיאפשר שימוש ב-OpenSSL החדש
RUN set -eux; \
    mv /usr/local/bin/python3 /usr/local/bin/python3-real; \
    printf '%s\n' \
      '#!/bin/sh' \
      'export LD_LIBRARY_PATH=/opt/openssl-3.0.2/lib' \
      'exec /usr/local/bin/python3-real "$@"' \
      > /usr/local/bin/python3; \
    chmod +x /usr/local/bin/python3

# התקנת תעודת NetFree
RUN curl -sL https://netfree.link/dl/unix-ca.sh | sh
