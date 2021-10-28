FROM python:3.8.2-alpine
WORKDIR /usr/src/app
EXPOSE 8000
ENV Port 8000
COPY . .
RUN pip install -qr requirements.txt
CMD ["python", "./envoy.py"]
