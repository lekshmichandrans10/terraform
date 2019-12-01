#!/usr/bin/env groovy
pipeline {

  agent any

  

  stages {

    stage('Checkout') {
      steps {
        withCredentials([azureServicePrincipal('SP_terratest')]) {
  sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
         }
        checkout scm
        
      }
    }

    stage('TF Plan') {
      steps {
        withCredentials([azureServicePrincipal('SP_terratest')]) {
  sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
         }
        container('terraform') {
          sh 'terraform init'
          sh 'terraform plan -out myplan'
        }
      }      
    }

    stage('Approval') {
      steps {
        withCredentials([azureServicePrincipal('SP_terratest')]) {
  sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
         }
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }

    stage('TF Apply') {
      steps {
        withCredentials([azureServicePrincipal('SP_terratest')]) {
  sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
         }
        container('terraform') {
          sh 'terraform apply -input=false myplan'
        }
      }
    }

  } 

}
