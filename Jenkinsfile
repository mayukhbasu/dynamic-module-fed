pipeline {
  agent any

  tools {
    nodejs 'NodeJS' // Ensure this matches the name given in Global Tool Configuration
    dockerTool 'Docker'
  }
  environment {
    DOCKER_BUILDKIT = "1"
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

    stage('Build Applications') {
      steps {
        script {
          if (params.BUILD_TARGET == 'dashboard' || params.BUILD_TARGET == 'all') {
            sh 'npm run nx:build:dashboard -- --verbose'
          }
          if (params.BUILD_TARGET == 'login' || params.BUILD_TARGET == 'all') {
            sh 'npm run nx:build:login -- --verbose'
          }
        }
      }
    }

   stage('Build Docker Image for Dashboard') {
      steps {
          // Build the Docker image for the dashboard application
          sh 'docker build -t dashboard-app -f apps/dashboard/Dockerfile.dashboard .'
      }
    }

    stage('Build Docker Image for Login') {
        steps {
            // Build the Docker image for the login application
            sh 'docker build -t login-app -f apps/login/Dockerfile.login .'
        }
      }

    stage('Deploy to Nginx') {
      steps {
        script {
          // Stop and remove the old container if it exists
          sh 'docker stop my-nginx-app || true && docker rm my-nginx-app || true'

          // Run the new container
          sh 'docker run -d -p 8080:80 --name my-nginx-app my-nginx-app'
        }
      }
    }

  }
}
