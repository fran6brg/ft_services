FROM telegraf:alpine

# RUN apk -f update 

# https://thenewstack.io/how-to-setup-influxdb-telegraf-and-grafana-on-docker-part-2/
RUN mkdir -p /etc/telegraf
COPY telegraf.conf /etc/telegraf/telegraf.conf
# COPY entrypoint.sh ./entrypoint2.sh
# EXPOSE 10255
CMD ["sh", "/entrypoint.sh", "-"]
