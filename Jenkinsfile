pipeline {
  agent any

  tools {
    nodejs 'NodeJS' // Ensure this matches the name given in Global Tool Configuration
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

    stage('Build Docker Image') {
      steps {
        // Build the Docker image with Nginx serving both applications
        sh 'docker build -t my-nginx-app -f nginx/Dockerfile.nginx .'
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
