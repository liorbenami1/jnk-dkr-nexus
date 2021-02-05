pipeline {
    agent {
        label "docker"
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
                OK "Go"
                submitter "Itay shechter"
                parameters {
                    string(name: 'BUILD_ID', defaultValue: 'latest', description: 'Build Number: x.y / string')
                }
            }
            steps{
                echo "====++++ building docker image ++++===="
                script{
                    sh 'docker build tag "my-image:${BUILD_ID}"'
                }
                
            }
            post{
                success{
                    echo "====++++ build success ++++===="
                    echo "uploading to nexus"
                    //docker push http://cicdvm:8081/repository/nexux-docker-repo/myhello:latest

                }
                failure{
                    echo "====++++ A execution failed++++===="
                }
        
            }
        }
    }
}