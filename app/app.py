from flask import Flask
import boto3

app = Flask(__name__)

def get_dynamic_string():
    ssm = boto3.client('ssm', region_name="eu-west-2")
    response = ssm.get_parameter(Name="dynamic_string-arqi")
    return response['Parameter']['Value']

@app.route('/')
def index():
    return f"<h1>The saved string is {get_dynamic_string()}</h1>"

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80)