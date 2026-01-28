M python:3.9-slim

# 1. Metadata (Optional but good practice)
LABEL maintainer="avinash.sre@example.com" description="Python Flask App"

# 2. Python Logs Real-time दिसावेत म्हणून हे सेटिंग (Most Important for SRE)
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

# 3. Healthcheck साठी 'curl' इन्स्टॉल करणे (Slim इमेजमध्ये curl नसते)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

RUN adduser --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

EXPOSE 5000

# 4. Healthcheck: कंटेनर जिवंत आहे ना हे Docker दर 30 सेकंदांनी तपासेल
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:5000/ || exit 1

# 5. Graceful Shutdown: कंटेनर बंद करताना ॲपला सेव्ह करायला वेळ देणे
STOPSIGNAL SIGINT

ENTRYPOINT ["python"]
CMD ["app.py"]











