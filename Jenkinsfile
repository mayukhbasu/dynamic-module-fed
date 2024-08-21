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
      steps {
        // Build the dashboard application
        sh 'npm run nx:build:dashboard -- --verbose'
      }
    }
    stage('Build Login') {
      steps {
        // Build the login application
        sh 'npm run nx:build:login -- --verbose'
      }
    }

    stage('Package Applications') {
      steps {
        // Package the built applications for deployment
        sh '''
          tar -czvf dashboard.tar.gz dist/apps/dashboard
          tar -czvf login.tar.gz dist/apps/login
        '''
      }
    }

    stage('Deploy to Nginx') {
            steps {
                // Use the SSH key for deployment
                sshagent(['bubul']) {
                    sh '''
                      scp dashboard.tar.gz ${NGINX_USER}@${NGINX_SERVER}:${NGINX_DEPLOY_DIR}/dashboard.tar.gz
                      scp login.tar.gz ${NGINX_USER}@${NGINX_SERVER}:${NGINX_DEPLOY_DIR}/login.tar.gz
                      
                      ssh ${NGINX_USER}@${NGINX_SERVER} "tar -xzvf ${NGINX_DEPLOY_DIR}/dashboard.tar.gz -C ${NGINX_DEPLOY_DIR}"
                      ssh ${NGINX_USER}@${NGINX_SERVER} "tar -xzvf ${NGINX_DEPLOY_DIR}/login.tar.gz -C ${NGINX_DEPLOY_DIR}"
                    '''
                }
            }
        }
  }
}
