
pipeline {
    agent {
        dockerfile {
            label 'php-node'
        }
    }
    if (env.BRANCH_NAME.startsWith("PR-")) {
        echo "Deploying to Dev environment after build"
        def ENV="staging"
    } else if (env.BRANCH_NAME.startsWith("Release_")) {
        echo "Deploying to Stage after build and Dev Deployment"
        def ENV="preprod"
    } else if (env.BRANCH_NAME.startsWith("master")) {
        echo "Deploying to PROD environment"
        def ENV="prod"
    }

    environment {
        CI = 'true'
        HOME = '.'
        DBLAB_STAGE_URL     = credentials('jenkins-dblab-stage-url')
        DBLAB_STAGE_TOKEN   = credentials('jenkins-dblab-stage-token')
    }
    stages {
        stage(' PGClone dblab tool') {
            steps {
                sh './jenkins/scripts/init-dblab.sh'
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
        stage('Check branch name') {
            steps {
                echo 'branch name ' + env.BRANCH_NAME
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
