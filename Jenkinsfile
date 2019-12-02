#!/usr/bin/env groovy
pipeline {

  agent any

 

  stages {

    stage('Checkout') {
      steps {
        node {
        withCredentials([azureServicePrincipal(credentialsId: 'SP_terratest',
                    subscriptionIdVariable: 'SUBS_ID',
                    clientIdVariable: 'CLIENT_ID',
                    clientSecretVariable: 'CLIENT_SECRET',
                    tenantIdVariable: 'TENANT_ID')])
        }
        checkout scm
        
      }
    }

    stage('TF Plan') {
       steps {
         
           sh 'terraform init'
           sh 'terraform plan -out myplan'
         
       }
     }

    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }

    stage('TF Apply') {
      steps {
        
          sh 'terraform apply -input=false myplan'
        
      }
    }

  } 

}
