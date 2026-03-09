import os
import boto3
from flask import Flask

AWS_ENDPOINT_URL = os.environ.get("AWS_ENDPOINT_URL", "http://localstack:4566")
REGION = os.environ.get("AWS_DEFAULT_REGION", "us-east-1")
BUCKET = os.environ.get("BUCKET_NAME", "images-bucket")
PREFIX = os.environ.get("PREFIX", "images/")

s3 = boto3.client(
    "s3",
    region_name=REGION,
    endpoint_url=AWS_ENDPOINT_URL,
)

app = Flask(__name__)

def list_keys():
    resp = s3.list_objects_v2(Bucket=BUCKET, Prefix=PREFIX)
    contents = resp.get("Contents", [])
    keys = [o["Key"] for o in contents if not o["Key"].endswith("/")]
    return keys

def presign(key: str) -> str:
    url = s3.generate_presigned_url(
        "get_object",
        Params={"Bucket": BUCKET, "Key": key},
        ExpiresIn=3600,
    )
    return url.replace("localstack:4566", "localhost:4566")

@app.get("/")
def index():
    keys = list_keys()
    items = "\n".join(
        f'<div style="margin:12px 0"><div>{k}</div><img src="{presign(k)}" style="max-width:800px"/></div>'
        for k in keys
    )
    return f"""
    <html>
      <body>
        <h2>Images from s3://{BUCKET}/{PREFIX} (LocalStack)</h2>
        <p>Sube archivos a: <code>{PREFIX}</code></p>
        {items if items else "<p>No hay imágenes aún.</p>"}
      </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)