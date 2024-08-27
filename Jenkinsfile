pipeline {
  agent any

  tools {
    nodejs 'NodeJS' // Ensure this matches the name given in Global Tool Configuration
  }

  environment {
    NGINX_SERVER = 'localhost'
    NGINX_USER = 'bubul' // Use your local user account for file transfers
    NGINX_DEPLOY_DIR = '/opt/homebrew/etc/nginx/html'
  }

  parameters {
    choice(
      name: 'BUILD_TARGET',
      choices: ['dashboard', 'login', 'all'],
      description: 'Choose which application(s) to build and deploy'
    )
  }

  stages {
    stage('Checkout') {
      steps {
        // Checkout code from GitHub repository
        git branch: 'mf-ci', url: 'https://github.com/mayukhbasu/dynamic-module-fed'
      }
    }
    stage('Install Dependencies') {
      steps {
        // Install npm dependencies
        sh 'npm install'
      }
    }

    stage('Build Dashboard') {
      when {
        expression { params.BUILD_TARGET == 'dashboard' || params.BUILD_TARGET == 'all' }
      }
      steps {
        // Build the dashboard application
        sh 'npm run nx:build:dashboard -- --verbose'
      }
    }

    stage('Build Login') {
      when {
        expression { params.BUILD_TARGET == 'login' || params.BUILD_TARGET == 'all' }
      }
      steps {
        // Build the login application
        sh 'npm run nx:build:login -- --verbose'
      }
    }

    stage('Package Applications') {
      when {
        expression { params.BUILD_TARGET == 'dashboard' || params.BUILD_TARGET == 'all' || params.BUILD_TARGET == 'login' }
      }
      steps {
        script {
          if (params.BUILD_TARGET == 'dashboard' || params.BUILD_TARGET == 'all') {
            sh 'tar -czvf dashboard.tar.gz dist/apps/dashboard'
          }
          if (params.BUILD_TARGET == 'login' || params.BUILD_TARGET == 'all') {
            sh 'tar -czvf login.tar.gz dist/apps/login'
          }
        }
      }
    }

    stage('Deploy to Nginx') {
      when {
        expression { params.BUILD_TARGET == 'dashboard' || params.BUILD_TARGET == 'login' || params.BUILD_TARGET == 'all' }
      }
      steps {
        withCredentials([sshUserPrivateKey(credentialsId: 'nginx-deploy-key', keyFileVariable: 'SSH_KEY')]) {
          script {
            if (params.BUILD_TARGET == 'dashboard' || params.BUILD_TARGET == 'all') {
              sh '''
                scp -i $SSH_KEY dashboard.tar.gz ${NGINX_USER}@${NGINX_SERVER}:${NGINX_DEPLOY_DIR}/dashboard.tar.gz
                ssh -i $SSH_KEY ${NGINX_USER}@${NGINX_SERVER} "tar -xzvf ${NGINX_DEPLOY_DIR}/dashboard.tar.gz -C ${NGINX_DEPLOY_DIR}"
              '''
            }
            if (params.BUILD_TARGET == 'login' || params.BUILD_TARGET == 'all') {
              sh '''
                scp -i $SSH_KEY login.tar.gz ${NGINX_USER}@${NGINX_SERVER}:${NGINX_DEPLOY_DIR}/login.tar.gz
                ssh -i $SSH_KEY ${NGINX_USER}@${NGINX_SERVER} "tar -xzvf ${NGINX_DEPLOY_DIR}/login.tar.gz -C ${NGINX_DEPLOY_DIR}"
              '''
            }
          }
        }
      }
    }
  }
}
