/* script {
    if (env.BRANCH_NAME.startsWith("PR-")) {
        echo "Deploying to Staging environment after build"
        env.ENV_CI = "staging"
    } else if (env.BRANCH_NAME.startsWith("Release_")) {
        echo "Deploying to preprod after build and Staging Deployment"
        env.ENV_CI = "preprod"
    } else if (env.BRANCH_NAME.startsWith("master")) {
        echo "Deploying to PROD environment"
        env.ENV_CI = "prod"
    }
} */

pipeline {
    agent {
        dockerfile true
    }
    environment {
        CI = 'true'
        HOME = '.'
        DBLAB_URL     = credentials('jenkins-dblab-stage-url')
        DBLAB_TOKEN   = credentials('jenkins-dblab-stage-token')
        PGUSER        = credentials('jenkins-pguser')
        PGPASSWORD    = credentials('jenkins-pgpassword')
        PGDATABASE    = credentials('jenkins-pgdatabase')
    }
    stages {
        stage('Init Dblab') {
            steps {
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
                script {
                    allJob = env.JOB_NAME.tokenize('/') as String[];
                    REPO_NAME = allJob[0];
                    CLONE_ID = allJob[0] + '_' + allJob[1]
                }
                script {
                    if (env.BRANCH_NAME.startsWith("PR-")) {
                        echo "Deploying to Staging environment after build"
                        ENV_CI = "staging"

                    } else if (env.BRANCH_NAME.startsWith("Release_")) {
                        echo "Deploying to preprod after build and Staging Deployment"
                        ENV_CI = "preprod"

                    } else if (env.BRANCH_NAME.startsWith("master")) {
                        echo "Deploying to PROD environment"
                        ENV_CI = "prod"
                    }
                }
                sh "./jenkins/scripts/init-dblab.sh $ENV_CI $DBLAB_URL $DBLAB_TOKEN"
            }
        }
        stage('Check Association PGClone/PR') {
            steps {
                echo "REPO_NAME = $REPO_NAME"
                echo "CLONE_ID = $CLONE_ID"
                echo "ENV_CI = $ENV_CI" // prints "ENV_CI = staging|preprod|prod"
                script {
                    RESULT = sh(
                        script: "./jenkins/scripts/check-association.sh ${env.BRANCH_NAME} $REPO_NAME $ENV_CI",
                        returnStdout: true
                    ).trim()
                }
                echo "RESULT = $RESULT"
            }
        }
        stage('Clone a DB snapshot') {
            when {
               expression { RESULT == "" }
            }
            steps {
                echo "REPO_NAME = $REPO_NAME"
                echo "ENV_CI = $ENV_CI" // prints "ENV_CI = staging|preprod|prod"
                script {
                    CLONE_JSON = sh(
                        script: "./jenkins/scripts/make-clone.sh $CLONE_ID $ENV_CI",
                        returnStdout: true
                    ).trim()
                }
                echo "CLONE_JSON = $CLONE_JSON"
                script {
                    JQ_RESULT = sh(
                        script: "./jenkins/scripts/jq-clone.sh $CLONE_ID",
                        returnStdout: true
                    ).trim()
                }
                echo "JQ_RESULT = $JQ_RESULT"
                RESULT = "x x x $CHANGE_AUTHOR x x x x x $JQ_RESULT"
            }
        }
        stage('PG Clone Connection Test') {
            steps {
                // Attention RESULT contient plusieurs strings séparés par un espace
                sh "./jenkins/scripts/test-pg.sh $RESULT"
            }
        }
        stage('Backup association PGClone') {
            when {
               expression { RESULT == "" }
            }
            steps {
                sh 'echo ./jenkins/scripts/insert-association.sh'
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


