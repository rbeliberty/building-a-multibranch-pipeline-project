
pipeline {
    agent {
        dockerfile true
    }


    environment {
        CI = 'true'
        HOME = '.'
        DBLAB_URL     = credentials('jenkins-dblab-stage-url')
        DBLAB_TOKEN   = credentials('jenkins-dblab-stage-token')
        ENV_CI        = ""
    }
    stages {
        stage('Get Env var') {
            steps {
                echo 'ENV_CI : ' + env.ENV_CI
                echo 'BRANCH_NAME : ' + env.BRANCH_NAME
                echo 'CHANGE_ID (PR NUMBER) : ' + env.CHANGE_ID
                echo 'CHANGE_AUTHOR : ' + env.CHANGE_AUTHOR
                echo 'CHANGE_TARGET : ' + env.CHANGE_TARGET
                echo 'CHANGE_BRANCH : ' + env.CHANGE_BRANCH
                echo 'CHANGE_FORK : ' + env.CHANGE_FORK
                echo 'BUILD_NUMBER : ' + env.BUILD_NUMBER
                echo 'BUILD_ID : ' + env.BUILD_ID
                echo 'BUILD_DISPLAY_NAME : ' + env.BUILD_DISPLAY_NAME
                echo 'JOB_NAME : ' + env.JOB_NAME
                echo 'JOB_BASE_NAME : ' + env.JOB_BASE_NAME
                echo 'BUILD_TAG : ' + env.BUILD_TAG
                echo 'GIT_BRANCH : ' + env.GIT_BRANCH
                echo 'GIT_LOCAL_BRANCH : ' + env.GIT_LOCAL_BRANCH
                echo 'GIT_URL : ' + env.GIT_URL
                echo 'GIT_COMMIT : ' + env.GIT_COMMIT
                echo 'GIT_COMMITTER_NAME : ' + env.GIT_COMMITTER_NAME
                echo 'GIT_AUTHOR_NAME : ' + env.GIT_AUTHOR_NAME
                sh "printenv"

                script {
                    if (env.BRANCH_NAME.startsWith("PR-")) {
                        withEnv(["ENV_CI='staging'"]) {
                            echo "Deploying to Staging environment after build"
                        }
                    } else if (env.BRANCH_NAME.startsWith("Release_")) {
                        withEnv(["ENV_CI='preprod'"]) {
                            echo "Deploying to preprod after build and Staging Deployment"
                        }
                    } else if (env.BRANCH_NAME.startsWith("master")) {
                        withEnv(["ENV_CI='prod'"]) {
                            echo "Deploying to PROD environment"
                        }
                    }
                }
            }
        }
        stage('Init dblab') {
            steps {
                sh './jenkins/scripts/init-dblab.sh $ENV_CI $DBLAB_URL $DBLAB_TOKEN'
            }
        }
        stage('Check PGClone and get one') {
            steps {
                sh './jenkins/scripts/pgclone.sh'
            }
        }
        stage('Clone a DB snapshot') {
            steps {
                sh "echo 'Clone deployment with ID snapshot'"
            }
        }

        stage('PG Connection Test') {
            steps {
                sh 'echo ./jenkins/scripts/pg.sh'
            }
        }
        stage('Backup association PGClone') {
            steps {
                sh 'echo ./jenkins/scripts/backup.sh'
            }
        }
        stage('Deliver for PR in Staging'){
            when {
                expression { BRANCH_NAME ==~ /PR-\d+/ } 
            }
            steps {
                sh 'echo ./jenkins/scripts/deliver-for-development.sh'
                input message: 'Finished using the web site ? (Click "Proceed" to continue)'
                sh 'echo ./jenkins/scripts/kill.sh'
            }
        }
        stage('Deliver for development') {
            when {
                branch 'dev'
            }
            steps {
                sh 'echo ./jenkins/scripts/deliver-for-development.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh 'echo ./jenkins/scripts/kill.sh'
            }
        }
        stage('Deploy for production') {
            when {
                branch 'production'
            }
            steps {
                sh 'echo ./jenkins/scripts/deploy-for-production.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh 'echo ./jenkins/scripts/kill.sh'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}

