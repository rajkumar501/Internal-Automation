
    pipeline{

         agent any

         stages {
         stage('Init parameters'){
            steps{ 
            container('terraform-az') {
                // Get SSH public for the VMSS from Jenkins
                withCredentials([sshUserPrivateKey(credentialsId: 'ssh_key_user', keyFileVariable: 'PUBLICKEY')]) {
                        sh  """
                        mkdir ./.ssh
                        cat $PUBLICKEY > ./.ssh/id_rsa.pub
                        """
                }
              }    
            } 
            }
         stage('Checkout'){
            steps{ 
            container('terraform-az') {
                // Get the terraform plan
                checkout scm    
            }
        }
         }
        stage('Terraform init'){
            steps{ 
            container('terraform-az') {
                // Initialize the plan 
                sh  """
                    cd terraform/
                    terraform init -input=false
                   """
            }
        }
        }
        stage('Terraform plan'){
            steps{ 
            container('terraform-az') {  
                
                sh  '''
                     az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
                    '''

                sh (script:"cd terraform-plans/ && terraform plan -out=tfplan")
                     
            }
        }
        }
        stage('Approval') {
                steps {
                    script {
                        def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
                            }
                    }
            }

        stage('Terraform apply'){
         steps{ 
            container('terraform-az') {
                // Apply the plan
                sh  """  
                    cd terraform-plans/
                    terraform apply -input=false -auto-approve "tfplan"
                   """
            }
        }
         }
         }

    
    }