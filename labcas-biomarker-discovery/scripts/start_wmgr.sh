#!/bin/bash

# start the rabbitmq consumers
# one consumer per workflow specified as script argument
for arg in "$@"; do
  echo "RabbitMQ consumer listening to queue ${arg}..."
  python /usr/local/oodt/rabbitmq/rabbitmq_client.py pull $arg 2 &
done

# start workflow manager through supervisor (in non-daemon mode)
/usr/local/bin/supervisord -c /etc/supervisor/supervisord-workflow.conf
