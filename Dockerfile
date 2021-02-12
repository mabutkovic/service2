FROM python:rc-alpine

COPY fwatchdog /usr/bin/fwatchdog

ENV fprocess="python entrypoint.py"
COPY entrypoint.py /

RUN pip install requests && chmod +x /usr/bin/fwatchdog

EXPOSE 8080
CMD [ "fwatchdog" ]