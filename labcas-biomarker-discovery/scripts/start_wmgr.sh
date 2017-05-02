#!/bin/bash

# must first start the workflow manager
# use supervisor with daemon mode
# command line option overrides option in configuration file
/usr/local/bin/supervisord -c /etc/supervisor/supervisord-wmgr.conf

# wait for workflow manager and rabbitmq server to start
sleep 10

# then start the rabbitmq consumers
# one consumer per workflow specified as script argument
for arg in "$@"; do
  echo "RabbitMQ consumer listening to queue ${arg}..."
  python /usr/local/oodt/rabbitmq/rabbitmq_client.py pull $arg 1 &
done

# tail log file to keep container running
tail -f /usr/local/oodt/cas-workflow/logs/cas_workflow.log
#tail -f /dev/null
