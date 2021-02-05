pipeline {
    agent any
    stages {
        stage ('Git Checkout') {
        steps {
            gitCheckout(
                branch: "master",
                url: "https://github.com/itay47/jnk-dkr-nexus.git"
            )}
        }
    }
}