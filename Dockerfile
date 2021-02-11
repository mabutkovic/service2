FROM python:3.9.1-slim-buster

COPY fwatchdog /usr/bin/fwatchdog

ENV fprocess="python entrypoint.py"
COPY entrypoint.py /

RUN pip install requests && chmod +x /usr/bin/fwatchdog

EXPOSE 8080
CMD [ "fwatchdog" ]