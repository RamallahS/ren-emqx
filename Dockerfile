FROM emqx/emqx:5.8.0

# Render assigns an environment variable $PORT dynamically.
# We create an entrypoint script to start EMQX properly.
RUN echo '#!/bin/sh' > /entrypoint.sh \
    && echo 'sed -i "s/18083/${PORT}/g" /etc/emqx/emqx.conf' >> /entrypoint.sh \
    && echo 'exec /opt/emqx/bin/emqx foreground' >> /entrypoint.sh \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
