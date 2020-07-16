
    pipeline{

         agent any

        stages {
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
                    cd terraform-plans/
                    terraform init -input=false
                   """
            }
        }
        }
        stage('Terraform plan'){
            steps{ 
            container('terraform-az') {  
                
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

        stage('Destroy Environment'){

            steps{
                container('terraform-az'){
                    sh """
                        cd terraform-plans/
                        terraform destroy -force 
                        """
                }

            }
        }
         }

    
    }
