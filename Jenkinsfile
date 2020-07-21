
    pipeline{
        agent{
        kubernetes{
        label 'terraform-agent'
        }
        }
        environment{

            ARM_ACCESS_KEY = credential('arm_access_key')
            TF_VAR_client_id = credential('tenant_id')
            TF_VAR_client_secret = credential('client_secret') 
        }
   
        stages {
         stage('Checkout'){
            steps{ 
            container('terraform') {
                // Get the terraform plan
                checkout scm    
            }
        }
         }
        stage('Terraform init'){
            steps{ 
            container('terraform') {
                // Initialize the plan 
                sh  """
                    cd terraform-plans/
                    terraform init -input=false
                   """
            }
        }
        }
        stage('Terraform plan'){
            steps{ 
            container('terraform') {  
                
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
            container('terraform') {
                // Apply the plan
                sh  """  
                    cd terraform-plans/
                    terraform apply -input=false -auto-approve "tfplan"
                   """
            }
        }
         }

        // stage('Destroy Environment'){
        //     when{
        //         para
        //     }
        //     steps{
        //         container('terraform'){
        //             sh """
        //                 cd terraform-plans/
        //                 terraform destroy -force 
        //                 """
        //         }

        //     }
        // }
         }

    
    }
