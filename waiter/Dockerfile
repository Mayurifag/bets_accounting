FROM postgres:${POSTGRES_VERSION:-12}-alpine

COPY wait_for_pg.sh /bin/
RUN chmod +x /bin/*

ENTRYPOINT ["wait_for_pg.sh"]
CMD ["db"]
