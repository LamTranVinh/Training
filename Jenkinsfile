pipeline {
    agent any
    stages {
        stage("Build"){
            steps {
                sh "echo hello"
            }
        }

        // stage("Deploy"){
        //     steps {
        //         sh "docker-compose build"
        //     }
        // }

        stage("Build-image"){
            steps {
                sh "docker build -t vinh6 ."
            }
        }

        
    }
}
