#!/bin/bash

PYTHON=/usr/bin/python3
AWS=/home/speedtest/.local/bin/aws
JUPYTER=/home/speedtest/.local/bin/jupyter
ROOT=/home/speedtest/speedtest

echo Testing internet speed
${PYTHON} ${ROOT}/src/speedtest.py >> ${ROOT}/data/data.csv

echo Building notebook
${JUPYTER} nbconvert --to html \
    --execute ${ROOT}/src/speedtest.ipynb \
    --output ${ROOT}/www/index.html

echo Deploying to S3
${AWS} s3 sync ${ROOT}/www s3://karepalas-speedtest/
