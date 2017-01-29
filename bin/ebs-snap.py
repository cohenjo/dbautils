#!/usr/bin/python


import requests
import boto3
import pprint

def get_instance_id():
    response = requests.get('http://169.254.169.254/latest/meta-data/instance-id')
    instance_id = response.text
    return instance_id


def main():
    ec2 = boto3.resource('ec2')
    instance_id=get_instance_id()
    devlst = ec2.Instance(instance_id).block_device_mappings
    pp = pprint.PrettyPrinter(indent=2)
    pp.pprint(devlst)

    #response = requests.get('http://169.254.169.254/latest/meta-data/block-device-mapping/ebs1')


__main__:
    main()
