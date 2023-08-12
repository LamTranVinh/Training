//Jenkinsfile
pipeline {
    agent any
    environment{
        DOCKER_IMAGE = "tuyetnhung/happy"
    }
    stages {
        stage('Terraform Init') {
            environment {
                AWS_DEFAULT_REGION = 'ap-northeast-2'
            }
            steps {
                script {
                    def tf = "/usr/local/bin/terraform"  // Note the slash before "usr".
                    sh """
                    ${tf} init
                    """
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    def tf = "/usr/local/bin/terraform"
                    sh """
                        ${tf} apply -auto-approve
                            -var "access_key=${AWS_CREDENTIALS}"
                            -var "secret_key=${AWS_CREDENTIALS}"
                        """
                    }
                }
            }
        }
        
        stage("Build"){
            options {
                timeout(time: 10, unit: 'MINUTES')
            }
            environment {
                DOCKER_TAG="${GIT_BRANCH.tokenize('/').pop()}-${GIT_COMMIT.substring(0,7)}"
            }
            steps {
                sh '''
                    cd /web-vote-python/
                    docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} . 
                    docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest
                    docker image ls | grep ${DOCKER_IMAGE}'''
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin'
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }

                //clean to save disk
                sh "docker image rm -f ${DOCKER_IMAGE}:${DOCKER_TAG}"
                sh "docker image rm -f ${DOCKER_IMAGE}:latest"
            }
        }
        stage("Deploy1") {
            options {
                timeout(time: 10, unit: 'MINUTES')
            }
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        def dockerPassword = credentials('dockerhub')
                        ansiblePlaybook(
                            credentialsId: 'ssh-ubuntu',
                            playbook: 'playbook.yml',
                            inventory: 'hosts',
                            become: 'yes',
                            extraVars: [
                                docker_password: dockerPassword
                            ]
                        )
                    }
                }
            }
        }
}
    post {
        success {
            echo "SUCCESSFULL"
        }
        failure {
            echo "FAILED"
        }
    }
}
