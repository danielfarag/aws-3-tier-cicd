import json
import boto3

def lambda_handler(event, context):
    ec2_client = boto3.client('ec2')
    ssm_client = boto3.client('ssm')

    body = json.loads(event['body']) 

    TARGET_TAG_KEY = 'Name'
    TARGET_TAG_VALUE = body.get('type')



    if 'body' in event and event['body'] is not None:
        body_string = event['body']
        body_content = json.loads(body_string)
        print("Parsed request body:", json.dumps(body_content, indent=2))




    COMMAND_TO_RUN = f'cd /home/ubuntu; docker compose down -v --remove-orphans && docker compose pull && docker compose up -d'
    
    instance_ids = []
    try:
        response = ec2_client.describe_instances(
            Filters=[
                {
                    'Name': f'tag:{TARGET_TAG_KEY}',
                    'Values': [TARGET_TAG_VALUE]
                },
                {
                    'Name': 'instance-state-name',
                    'Values': ['running'] 
                }
            ]
        )

        for reservation in response['Reservations']:
            for instance in reservation['Instances']:
                instance_ids.append(instance['InstanceId'])

    except Exception as e:
        pass

    try:
        response = ssm_client.send_command(
            InstanceIds=instance_ids,
            DocumentName='AWS-RunShellScript',
            Parameters={'commands': [COMMAND_TO_RUN]}
        )

        return {
            'statusCode': 200,
            'body': json.dumps({
                'type' : TARGET_TAG_VALUE,
                'message': f"Successfully executed command '{COMMAND_TO_RUN}' on instances with tag {TARGET_TAG_KEY}={TARGET_TAG_VALUE}",
            })
        }

    except Exception as e:
        print(f"Error sending SSM command: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error sending SSM command: {str(e)}")
        }