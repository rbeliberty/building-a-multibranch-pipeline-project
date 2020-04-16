pipeline {
    agent { dockerfile true }
    environment {
        CI = 'true'
        HOME = '.'
        DBLAB_STAGE_URL     = credentials('jenkins-dblab-stage-url')
        DBLAB_STAGE_TOKEN   = credentials('jenkins-dblab-stage-token')
    }
    stages {
        stage('Install PGClone dblab tool') {
            steps {
                sh "which dblab"
                sh("dblab init --environment-id=staging --url=$DBLAB_STAGE_URL --token=$DBLAB_STAGE_TOKEN --insecure")
            }
        }
        stage('Check PGClone') {
            steps {
                sh 'dblab snapshot list'
            }
        }
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Check branch name') {
            steps {
                echo 'branch name ' + env.BRANCH_NAME

                /*if (env.BRANCH_NAME.startsWith("Feature_")) {
                    echo "Deploying to Dev environment after build"
                } else if (env.BRANCH_NAME.startsWith("Release_")) {
                    echo "Deploying to Stage after build and Dev Deployment"
                } else if (env.BRANCH_NAME.startsWith("master")) {
                    echo "Deploying to PROD environment"
                }*/
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deliver for PR in Staging'){
            when {
                expression { BRANCH_NAME ==~ /PR-\d+/ } 
            }
            steps {
                sh './jenkins/scripts/deliver-for-development.sh'
                input message: 'Finished using the web site ? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        }
        stage('Deliver for development') {
            when {
                branch 'dev'
            }
            steps {
                sh './jenkins/scripts/deliver-for-development.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        }
        stage('Deploy for production') {
            when {
                branch 'production'
            }
            steps {
                sh './jenkins/scripts/deploy-for-production.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        }
    }
}
