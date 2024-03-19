import json
import boto3
import os

def log_to_cloudwatch(message):
    # This function will print a JSON string, which CloudWatch will interpret as structured logs.
    print(json.dumps(message))

#####rest of code redacted