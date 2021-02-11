pipeline {
    agent {
        label "docker"
    }
    environment{
        BUILD_TAG = 'NO-TAG'
    }
    stages {

        stage ('Git Checkout') {
            steps {
                git "https://github.com/liorbenami1/jnk-dkr-nexus.git"
            }
        }
        
        stage("Build docker image"){
            
            input {
                message "Enter build number"
                ok "Go!"
                submitter "Mr. Miagi"
                parameters {
                    string(name: 'BUILD_ID', defaultValue: 'latest', description: 'Build Number: x.y / string')
                }
            }
            
            steps{
                echo "====++++ building docker image ++++===="
                script{
                    BUILD_TAG = "${BUILD_ID}"
                    echo "${BUILD_TAG}"
                    sh "docker build -t my-image:$BUILD_TAG -t 192.168.1.201:8082/my-image:$BUILD_TAG ."
                }
                
            }
            
            post{
                success{
                    echo "====++++ build success ++++===="

                    script{
                        sh 'docker images'
                        sh 'docker ps'
                        sh "docker run --rm --name my-image my-image:$BUILD_TAG"
                    }
                }
                failure{
                    echo "====++++ build execution failed ++++===="
                }
        
            }
        }
        
        stage("upload to nexus artifactory"){
            
            input {
                message "Upload to Nexus artifactory?"
            }
            
            steps{
                echo "====++++ uploading to nexus artifactory ++++===="
                
                script{
                    echo "login to nexus..."
                    //https://blog.sonatype.com/using-nexus-3-as-your-repository-part-3-docker-images

                    withCredentials([usernamePassword(credentialsId: 'dff4171e-b960-4231-8c84-372f19b502bc', passwordVariable: 'NEXUS_CRED_PSW', usernameVariable: 'NEXUS_CRED_USR')]) {

                        sh 'docker login -u ${NEXUS_CRED_USR} -p ${NEXUS_CRED_PSW} http://192.168.1.201:8082/'
                    
                        try {
                            sh "docker push 192.168.1.201:8082/my-image:$BUILD_TAG"
                        }
                        catch (exception) {
                            echo 'Exception: $exception'
                        }
                    }
                }
            }

            post{
                success{
                    echo "====++++ Upload to registry success ++++===="

                    script{
                        //logout the registry
                        sh "docker logout"
                        
                        //remove local images to cleanup storage 
                        //sh "docker rmi my-image:$BUILD_TAG cicdvm:8082/my-image:$BUILD_TAG"
                    }
                }
                failure{
                    echo "====++++ Upload to registry failed ++++===="
                }
            }
        }
    }
}
