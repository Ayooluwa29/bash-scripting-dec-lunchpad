#!/bin/bash

tail  /home/jesuniyig/data_pipeline/logs/preprocess.log | grep -i "error\|warning\|fail" | tee -a /home/jesuniyig/data_pipeline/logs/monitor.log

