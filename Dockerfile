FROM python:3.9-slim
RUN addgroup -S nonroot \
    && adduser -S nonroot -G nonroot

USER nonroot
WORKDIR /app
COPY ./app.py /app
EXPOSE 5000
CMD ["python", "/app/app.py"]
