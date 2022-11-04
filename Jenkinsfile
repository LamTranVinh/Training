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
                sh "docker run -d -p 80:80 vinh6"
            }
        }

         stage("Deploy"){
            steps {
                sh "docker-compose build"
                sh "docker-compose up"
            }
        }


        
    }
}
