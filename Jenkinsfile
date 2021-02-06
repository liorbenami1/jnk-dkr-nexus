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
                git "https://github.com/itay47/jnk-dkr-nexus.git"
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
                    sh "docker build -t my-image:$BUILD_TAG ."
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
                    NEXUS_CRED = credentials("cacd3c2b-63f8-4fb0-a0df-dc72b45b99c5")
                    sh 'docker login -u NEXUS_CRED_USR -p NEXUS_CRED_PSW http:/CICD:8082/repository/nexux-docker-repo/'
                    
                    try {
                        sh "docker push http://CICD:8082/repository/nexux-docker-repo/my-image:$BUILD_TAG"
                    }
                    catch (exception) {
                        echo 'Exception: $exception'
                    }
                    
                }

            }
        }
    }
}