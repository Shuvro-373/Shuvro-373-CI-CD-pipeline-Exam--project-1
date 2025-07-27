pipeline {
    agent any

    tools {
        jdk 'jdk21'
        nodejs 'nodejs24'
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout from Git') {
            steps {
                git url: 'https://github.com/Shuvro-373/Shuvro-373-CI-CD-pipeline-Exam--project-1.git', branch: 'master'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.projectKey=exam-project \
                        -Dsonar.projectName=exam-project'''
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('OWASP Dependency-Check') {
            steps {
                dependencyCheck additionalArguments: '--scan . --format XML', odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
                archiveArtifacts artifacts: '**/dependency-check-report.*', onlyIfSuccessful: true
            }
        }

        stage('Trivy Filesystem Scan') {
            steps {
                sh '''
                    trivy fs . \
                    --format table \
                    --severity HIGH,CRITICAL \
                    --no-progress > trivyfs.txt
                '''
                archiveArtifacts artifacts: 'trivyfs.txt', onlyIfSuccessful: true
            }
        }

        stage("Docker Build & Push") {
            steps {
                script {
                    def GIT_COMMIT = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    withDockerRegistry(credentialsId: 'dockerhub-creds') {
                        sh """
                            docker build -t shuvro373/exam-project:${GIT_COMMIT} -t shuvro373/exam-project:latest .
                            docker push shuvro373/exam-project:${GIT_COMMIT}
                            docker push shuvro373/exam-project:latest
                        """
                    }
                }
            }
        }

        stage("Trivy Image Scan") {
            steps {
                sh '''
                    trivy image shuvro373/exam-project:latest \
                    --severity HIGH,CRITICAL \
                    --format table \
                    --no-progress > trivy.txt
                '''
                archiveArtifacts artifacts: 'trivy.txt', onlyIfSuccessful: true
            }
        }

        stage('Deploy to Container') {
            steps {
                sh '''
                    docker rm -f exam-project || true
                    docker run -d --name exam-project -p 8000:8000 shuvro373/exam-project:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig(credentialsId: 'k8s') {
                        sh 'kubectl apply -f deployment.yaml'
                    }
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Pipeline failed. Check logs above."
        }
        success {
            echo "✅ Pipeline completed successfully!"
        }
    }
}
