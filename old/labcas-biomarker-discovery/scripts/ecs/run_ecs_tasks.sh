#!/bin/sh
# Script that starts N ECS tasks, each one running 1 iteration of the biomarker discovery stock pipeline.
#
# Usage: ./run_ecs_tasks.sh N

# submit NCV workflows
NUM_TASKS=$1
for i in `seq 1 $NUM_TASKS`
do
  aws ecs run-task --task-definition LabcasBiomarkerDiscoveryTask:4 --count 1 --region us-west-2 --cluster LucasCluster \
      --overrides "{ \"containerOverrides\": [ { \"name\": \"labcas-biomarker-discovery\", \"command\": [\"$i\"] } ] }"
  sleep 1
done
