pipeline {
    agent {
        label "docker"
    }
    stages {
        stage ('Git Checkout') {
        steps {
            gitCheckout(
                branch: "master",
                url: "https://github.com/itay47/jnk-dkr-nexus.git"
            )}
        }
        stage("Build docker image"){
            steps{
                echo "====++++ building docker image ++++===="
                docker build -t myhello:latest
            }
            post{
                success{
                    echo "====++++ build success ++++===="
                    echo "uploading to nexus"
                    docker push http://cicdvm:8081/repository/nexux-docker-repo/myhello:latest

                }
                failure{
                    echo "====++++ A execution failed++++===="
                }
        
            }
        }
    }
}