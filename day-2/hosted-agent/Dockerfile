# Build context is staged by notebook 07: hosted-agent/* + shared/ (so /app/shared/fsi_common.py exists).
FROM python:3.12-slim
ENV PYTHONNOUSERSITE=1 PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --pre -r requirements.txt
COPY main.py .
COPY shared/ shared/
EXPOSE 8088
CMD ["python", "main.py"]
