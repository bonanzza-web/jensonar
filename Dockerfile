FROM python:3.9-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    procps \
    && rm -rf /var/lib/apt/lists/* \
    && addgroup -S nonroot \
    && adduser -S nonroot -G nonroot
USER nonroot
WORKDIR /app
COPY ./app.py /app
EXPOSE 5000
CMD ["python", "/app/app.py"]
