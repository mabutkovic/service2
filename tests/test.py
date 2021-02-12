import requests
import yaml
import sys



if __name__ == "__main__":

    with open(f"{sys.argv[1]}-workflow/values.{sys.argv[2]}.{sys.argv[3]}.yaml", 'r') as stream:
            yaml_content = yaml.safe_load(stream)
            service_port = yaml_content["port"]
            print(requests.post(f"http://127.0.0.1:{service_port}", data="https://www.avl.com/?avlregion=GLOBAL&groupId=10138&lang=en_US").text)


