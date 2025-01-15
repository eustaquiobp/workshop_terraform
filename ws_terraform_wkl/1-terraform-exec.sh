#!/bin/bash

# Verifica se o Terraform está instalado
if ! command -v terraform &> /dev/null
then
    echo "⚠️ Terraform não está instalado. Por favor, instale o Terraform e tente novamente."
    exit 1
fi

# Verifica se pelo menos um argumento foi passado
if [ $# -lt 1 ]
then
    echo
    echo "Informe o ambiente"
    echo "$0 <DEV | HML | PRD> [apply | destroy]"
    echo
    exit 1
fi

ambiente=$1
AMBIENTE=${ambiente^^}
repo=$(basename "$PWD")

# Substitui as linhas no arquivo local_vars.tf para usar local.repository sem aspas
sed -i.bak "s|Repository *= *\".*\"|Repository = local.repository|; s|Repository *= *[^\"].*|Repository = local.repository|" local_vars.tf
sed -i.bak "s|repository *= *\".*\"|repository = \"$repo\"|; s|repository *= *[^\"].*|repository = \"$repo\"|" local_vars.tf

# Remove o diretório .terraform
echo "ℹ️ Removendo diretório .terraform..."
rm -rf .terraform

# Inicializa o Terraform com o backend configurado
echo "ℹ️ Inicializando o Terraform..."
terraform init -backend=true -backend-config="key=conta-$AMBIENTE/$repo.tfstate"

# Executa o plan do Terraform com o arquivo de variáveis específico do ambiente
echo "ℹ️ Executando terraform plan para o ambiente $AMBIENTE..."
terraform plan -var-file=tfvars/$ambiente.tfvars

# Verifica se o segundo argumento é "apply" ou "destroy"
if [ "$2" == "apply" ]
then
    echo "ℹ️ Aplicando configuração para o ambiente $AMBIENTE..."
    terraform apply -var-file=tfvars/$ambiente.tfvars
elif [ "$2" == "destroy" ]
then
    echo "ℹ️ Destruindo configuração para o ambiente $AMBIENTE..."
    terraform destroy -var-file=tfvars/$ambiente.tfvars
fi
