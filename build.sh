#!/bin/bash

PYTHON=/home/burak/.conda/envs/py36/bin/python
AWS=/home/burak/.conda/envs/py36/bin/aws
JUPYTER=/home/burak/.conda/envs/py36/bin/jupyter
ROOT=/home/burak/Projects/speedtest

echo Testing internet speed
${PYTHON} ${ROOT}/src/speedtest.py >> ${ROOT}/data/data.csv

echo Building notebook
${JUPYTER} nbconvert --to html \
    --execute ${ROOT}/src/speedtest.ipynb \
    --output ${ROOT}/www/index.html

echo Deploying to S3
${AWS} s3 sync ${ROOT}/www s3://karepalas-speedtest/ \
    --profile buraky
