import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['TABLE_NAME'])

def lambda_handler(event, context):
    # Processamento do arquivos de exemplo
    for record in event['Records']:
        s3 = record['s3']
        bucket = s3['bucket']['name']
        key = s3['object']['key']

        # Faça algo com o arquivo (por exemplo, conte linhas)
        result = process_file(bucket, key)

        # Salve no DynamoDB
        table.put_item(Item={'id': key, 'result': result})

    return {
        'statusCode': 200,
        'body': json.dumps('Processamento concluído.')
    }

def process_file(bucket, key):
    # Função de exemplo que processa o arquivo
    return 42  # Retorna um valor de exemplo
