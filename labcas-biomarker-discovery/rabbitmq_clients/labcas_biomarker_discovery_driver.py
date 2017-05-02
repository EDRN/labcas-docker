# Python script to drive the LabCAS biomarker-discovery pipeline:
# will start workflows for N cross-validations and wait until all workflows are completed.
#
# Usage: python labcas_biomarker_discovery_driver.py <number_of_cross_validations>

import logging
import sys
import datetime
import time
from rabbitmq_producer import publish_messages, wait_for_queues

LOG_FORMAT = '%(levelname)s: %(message)s'
LOGGER = logging.getLogger(__name__)
LOG_FILE = "rabbitmq_producer.log" # in current directory

# OODT workflow event name == RabbitMQ message queue name
WORKFLOW = 'biomarker-discovery' 


def main(ncv):
    
    logging.basicConfig(level=logging.CRITICAL, format=LOG_FORMAT)
        
    startTime = datetime.datetime.now()
    logging.critical("Start Time: %s" % startTime.strftime("%Y-%m-%d %H:%M:%S") )
    
    # start workflows by sending 1 message for each cross-validation
    for icv in range(1, ncv+1):
        LOGGER.info("Submitting workflow for cross-validation #: %s" % icv)

        msg_queue = WORKFLOW
        num_msgs = 1
        msg_dict = { 'CrossValidationIterationNumber': '%s' % icv, 
                     'TrainingSet': 'GSE4115_10female_10male.rds' }
        publish_messages(msg_queue, num_msgs, msg_dict)
        
        # wait before submitting the next iteration
        time.sleep(1)
    
    # wait for RabbitMQ server to process all messages in all queues
    wait_for_queues(delay_secs=10)
    
    stopTime = datetime.datetime.now()
    logging.critical("Stop Time: %s" % stopTime.strftime("%Y-%m-%d %H:%M:%S") )
    logging.critical("Elapsed Time: %s secs" % (stopTime-startTime).seconds )


if __name__ == '__main__':
    """ Parse command line arguments. """
    
    if len(sys.argv) < 1:
        raise Exception("Usage: python labcas_biomarker_discovery_driver.py <number_of_cross_validations>")
    else:
        ncv = int( sys.argv[1] )

    main(ncv)
