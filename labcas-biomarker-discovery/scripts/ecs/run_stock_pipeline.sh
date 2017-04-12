#!/bin/sh
# Script that runs 1 iteration of the biomarker discovery stock pipeline.
# The iteration number is provided as input argument.
# Output is written to $LABCAS_STAGING

cd $LABCAS_STAGING
R --no-save < $LABCAS_HOME/workflows/biomarker-discovery/pges/run_stock_pipeline_iter.R --args $1
