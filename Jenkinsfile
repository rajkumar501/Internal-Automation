 
{   

    pipeline{
         stage('Init parameters'){
            container('terraform-az') {
                // Get SSH public for the VMSS from Jenkins
                withCredentials([sshUserPrivateKey(credentialsId: '<your-public-key-id>', keyFileVariable: 'PUBLICKEY')]) {
                        sh  """
                        mkdir /home/jenkins/.ssh
                        cat $PUBLICKEY >/home/jenkins/.ssh/id_rsa.pub
                        """
                    }     
            }
         }
         stage('Checkout'){
            container('terraform-az') {
                // Get the terraform plan
                git url: gitRepo, branch: 'master'
            }
        }
        stage('Terraform init'){
            container('terraform-az') {
                // Initialize the plan 
                sh  """
                    cd terraform-plans/create-vmss-from-image
                    terraform init -input=false
                   """
            }
        }
        stage('Terraform plan'){
            container('terraform-az') {  
                
                // Get the VM image ID for the VMSS  
                sh  '''
                     az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
                    '''

                image_id = sh (
                            script: "az image show -g $vm_images_rg -n $image_name --query '{VMName:id}' --out tsv",
                            returnStdout: true).trim()

                sh (script:"cd terraform-plans/create-vmss-from-image && terraform plan -out=tfplan -input=false -var 'terraform_resource_group='$vmss_rg -var 'terraform_vmss_name='$vmss_name -var 'terraform_azure_region='$location -var 'terraform_image_id='$image_id")
                     
            }
        }
       
        stage('Terraform apply'){
            container('terraform-az') {
                // Apply the plan
                sh  """  
                    cd terraform-plans/create-vmss-from-image
                    terraform apply -input=false -auto-approve "tfplan"
                   """
            }
        }
        stage('Upload tfstate'){
            container('terraform-az') {
                // Upload the state of the plan to Azure Blob Storage
                sh (script: "cd terraform-plans/create-vmss-from-image && tar -czvf ~/workspace/${env.JOB_NAME}/$deployment'.tar.gz' .")
                sh "pwd"
                azureUpload blobProperties: [cacheControl: '', contentEncoding: '', contentLanguage: '', contentType: '', detectContentType: true], containerName: '<container-name>', fileShareName: '', filesPath: '${deployment}.tar.gz', storageCredentialId: '<jenkins-storage-id>', storageType: 'blobstorage'
                
            }
        }
    
    }
}

