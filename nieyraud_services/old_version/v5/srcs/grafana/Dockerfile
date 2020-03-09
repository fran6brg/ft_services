FROM grafana/grafana:6.4.0

COPY grafana.db /var/lib/grafana/grafana
RUN touch /var/lib/grafana/grafana.db
RUN cat /var/lib/grafana/grafana > /var/lib/grafana/grafana.db
RUN chmod 666 /var/lib/grafana/grafana.db
RUN rm /var/lib/grafana/grafana

EXPOSE 3000

CMD ["sh", "run.sh"]