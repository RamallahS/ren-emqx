FROM emqx/emqx:5.8.0

# Switch to root to create the entrypoint script
USER root

# Create the entrypoint script in a writable directory
RUN echo '#!/bin/sh' > /opt/emqx/entrypoint.sh \
    && echo 'sed -i "s/18083/${PORT}/g" /etc/emqx/emqx.conf' >> /opt/emqx/entrypoint.sh \
    && echo 'exec /opt/emqx/bin/emqx foreground' >> /opt/emqx/entrypoint.sh \
    && chmod +x /opt/emqx/entrypoint.sh

# Change ownership of the script to the emqx user
RUN chown emqx:emqx /opt/emqx/entrypoint.sh

# Switch back to the non-root emqx user for security
USER emqx

ENTRYPOINT ["/opt/emqx/entrypoint.sh"]
