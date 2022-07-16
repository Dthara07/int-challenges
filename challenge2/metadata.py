import requests
import sys

def get_instance_region():
    instance_identity_url = "http://169.254.169.254/latest/dynamic/instance-identity/document"
    r = requests.get(instance_identity_url)
    response_json = r.json()
    args = sys.argv
    if len(args) > 1:
      for index, arg in enumerate(args):
        if index > 0:
          print(response_json.get(arg))
    else:
      print(response_json)

get_instance_region()