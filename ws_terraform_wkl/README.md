
Projeto Terraform com AWS Lambda e S3
Este projeto demonstra a utilização de Terraform para provisionamento de infraestrutura AWS, incluindo um bucket S3, uma função Lambda, uma tabela DynamoDB, e triggers do S3 para a Lambda. A proposta é mostrar a configuração e deploy de múltiplos ambientes (DEV, HML, PRD) utilizando arquivos .tfvars.

Estrutura do Projeto
Bucket S3: Armazena arquivos de uploads.

Lambda Function: Processa os arquivos.

DynamoDB Table: Armazena os resultados do processamento.

Trigger do S3: Chama a função Lambda ao detectar novos uploads.

Arquivos Importantes
xyz_vars.tf: Define variáveis que serão usadas no projeto.
xyz_main.tf: Configuração principal dos recursos AWS.
xyz_outs.tf: Configura informações de outputs.

-> Pasta TFVARS
dev.tfvars: Variáveis específicas para o ambiente de desenvolvimento.
hml.tfvars: Variáveis específicas para o ambiente de homologação.
prd.tfvars: Variáveis específicas para o ambiente de produção.

Requisitos
Terraform instalado.
AWS CLI configurado com credenciais apropriadas.

Como configurar e testar o projeto
1. Inicialize o Terraform
No diretório do projeto, execute:
-> terraform init -backend=true -backend-config="key=/conta-$AMBIENTE/$repo.tfstate"

2. Teste o plano de Terraform
Para visualizar o plano do Terraform, utilize o arquivo de variáveis correspondente ao ambiente desejado. Exemplo para o ambiente DEV:
-> terraform plan -var-file=dev.tfvars

3. Aplique a configuração
Para aplicar a configuração e provisionar os recursos, execute:
-> terraform apply -var-file=dev.tfvars

4. Promoção para outro ambiente
Para promover o código para HML ou PRD, basta trocar o arquivo .tfvars utilizado:

Arquivo lambda_function.py
O código da função Lambda se encontra no arquivo lambda_function.py. Certifique-se de fazer upload do código em um arquivo .zip para o S3 para que o Terraform consiga criar a Lambda Function corretamente.

Explicação dos Arquivos .tfvars
Os arquivos .tfvars definem variáveis específicas para cada ambiente, permitindo fácil adaptação e promoção do código entre DEV, HML, e PRD. Aqui está um exemplo do arquivo dev.tfvars:

hcl
environment          = "DEV"
s3_bucket_name       = "meu-bucket-dev"
dynamodb_table_name  = "workshop-results-dev"
lambda_memory_size   = 128
lambda_timeout       = 10
Mudando os valores desses arquivos, você pode promover o mesmo código para diferentes ambientes com diferentes configurações de recursos.

Funcionamento do Workload
Este projeto simula um fluxo básico de processamento de arquivos utilizando serviços da AWS. Aqui está uma visão completa do workflow:

1. Upload do Arquivo no S3
Usuário ou sistema: Sobe um arquivo para o bucket S3.

Evento: A adição de um novo arquivo no S3 aciona um evento.

2. Trigger do Lambda
Evento do S3: O evento é capturado pelo S3 e uma notificação é enviada à função Lambda.

Lambda: A função Lambda é invocada automaticamente.

3. Processamento na Lambda
Processamento:

A função Lambda recebe o evento contendo informações sobre o arquivo recém-carregado.

Exemplo de Processamento: Contar linhas de um arquivo CSV.

O resultado é preparado.

4. Preenchimento do DynamoDB
Armazenamento:

Após o processamento, os resultados são armazenados na tabela DynamoDB.

Informações como o nome do arquivo e o resultado do processamento são gravadas.

Isso garante a persistência dos dados e permite consultas posteriores.