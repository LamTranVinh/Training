pipeline {
    agent any
    stages {
        stage("Build"){
            steps {
                sh "echo hello"
            }
        }

        stage("Build-image"){
            steps {
                sh "docker build -t vinh6 ."
            }
        }

         stage("Deploy"){
            steps {
                sh "docker-compose up -d "
            }
        }


        
    }
}
