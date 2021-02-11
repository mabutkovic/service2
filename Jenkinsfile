pipeline {
    agent any
    environment {
        VERSION_NUMBER = sh(script: 'cat version.txt ', returnStdout: true).trim()
    }
    stages {
        stage('Build') {
            steps {
                script {
                    sh(script: "source /etc/profile; docker build . -t mabutkovic/service2:$VERSION_NUMBER")
                    sh(script: "source /etc/profile; echo $VERSION_NUMBER")
                }
            }
        }
        stage('Unit Test') {
            steps {
                script {
                    sh(script: "date -u")
                }
            }
        }
        stage('Integration Test') {
            steps {
                script {
                    sh(script: "date -u")
                }
            }
        }
        stage('Publish Artifact') {
            steps {
                script {
                    sh(script: "source /etc/profile; docker push mabutkovic/service2:$VERSION_NUMBER")
                }
            }
        }
        stage('Projects') {
            parallel {
                stage('Project1') {
                    stages {
                        stage('Deploy to Staging') {
                            steps {
                                sh(script: "source /etc/profile; helm upgrade --set version=$VERSION_NUMBER --set SERVICE1_URL=http://project1-staging-service1-svc:8080 -f service2-workflow/values.p1.staging.yaml p1-staging-service2-workflow ./service2-workflow")
                            }
                        }
                        stage('Smoke Test') {
                            steps {
                                echo "Executing this stage first"
                            }
                        }
                        stage('End to End Test') {
                            steps {
                                echo "Executing this stage first"
                            }
                        }
                        stage('Deploy to Production') {
                            steps {
                                sh(script: "source /etc/profile; helm upgrade --set version=$VERSION_NUMBER --set SERVICE1_URL=http://project1-prod-service1-svc:8080 -f service2-workflow/values.p1.prod.yaml p1-prod-service2-workflow ./service2-workflow")
                            }
                        }
                    }
                }
                stage('Project2') {
                    stages {
                        stage('Deploy to Staging') {
                            steps {
                                sh(script: "source /etc/profile; helm upgrade --set version=$VERSION_NUMBER --set SERVICE1_URL=http://project2-staging-service1-svc:8080 -f service2-workflow/values.p2.staging.yaml p2-staging-service2-workflow ./service2-workflow")
                            }
                        }
                        stage('Smoke Test') {
                            steps {
                                echo "Executing this stage first"
                            }
                        }
                        stage('End to End Test') {
                            steps {
                                echo "Executing this stage first"
                            }
                        }
                        stage('Deploy to Production') {
                            steps {
                                sh(script: "source /etc/profile; helm upgrade --set version=$VERSION_NUMBER --set SERVICE1_URL=http://project2-prod-service1-svc:8080 -f service2-workflow/values.p2.prod.yaml p2-prod-service2-workflow ./service2-workflow")
                            }
                        }
                    }
                }
            }
        }
    }
}