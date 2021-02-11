FROM alpine

RUN apk add --no-cache python2 && apk add --no-cache py-pip

COPY fwatchdog /usr/bin/fwatchdog

ENV fprocess="python entrypoint.py"
COPY entrypoint.py /

RUN pip install requests && chmod +x /usr/bin/fwatchdog

EXPOSE 8080
CMD [ "fwatchdog" ]