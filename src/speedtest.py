import os
import re
import subprocess
import datetime

response = subprocess.Popen('speedtest-cli --simple', shell=True, stdout=subprocess.PIPE).stdout.read().decode()

ping = re.findall('Ping:\s(.*?)\s', response, re.MULTILINE)
download = re.findall('Download:\s(.*?)\s', response, re.MULTILINE)
upload = re.findall('Upload:\s(.*?)\s', response, re.MULTILINE)

try:
    if os.stat('../data/data.csv').st_size == 0:
        print('Datetime,Ping (ms),Download (Mbit/s),Upload (Mbit/s)')
except:
    pass

print(f'{datetime.datetime.now()},{ping[0]},{download[0]},{upload[0]}')
