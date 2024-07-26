pipeline {
  agent any

  tools {
    nodejs 'NodeJS' // Ensure this matches the name given in Global Tool Configuration
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
  }
}
