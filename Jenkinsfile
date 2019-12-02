#!/usr/bin/env groovy
pipeline {

     agent none 
     

  stages {
    stage('Testversionofterraform') {
            steps {
                sh 'terraform --version'
            }
        }

    stage('Checkout') {
      steps {
       withCredentials([azureServicePrincipal('SP_terratest')])
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
