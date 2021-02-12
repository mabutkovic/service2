def list_projects = ["p1", "p2", "p3"]
def list_environments = ["staging", "prod"]
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

        stage('Deployment Stage') {

            steps {
                script {
                    for (int i = 0; i < list_projects.size(); i++) {
                        for (int j = 0; j < list_environments.size(); j++) {

                            stage(list_projects[i] + '-' + list_environments[j] + ' deploy') {
                                sh(script: "source /etc/profile; helm upgrade --install --set version=$VERSION_NUMBER --set SERVICE1_URL=http://"+list_projects[i]+"-staging-service1-svc:8080 -f service2-workflow/values." + list_projects[i] + "." + list_environments[j] + ".yaml " + list_projects[i] + "-" + list_environments[j] + "-service2-workflow ./service2-workflow")
                            }
                            if (list_environments[j] == 'staging') {
                                stage(list_projects[i] + '-' + list_environments[j] + ' Smoke Test') {
                                    script {
                                        echo "Executing"
                                    }
                                }
                                stage(list_projects[i] + '-' + list_environments[j] + ' End to End Test') {
                                    script {
                                        echo "Executing"
                                    }
                                }
                            }

                        }
                    }
                }
            }
        }

    }
}