pipeline {
    agent none
    environment {
        // This forces the Docker CLI to use the local unix socket
        DOCKER_HOST = ''
    }
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:3.8-alpine3.16'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'python3.8 -m py_compile sources/prog.py sources/calc.py'
                stash(name: 'compiled-results', includes: 'sources/*.py*')
            }
        }
        stage('Debug Env') {
   		 agent any
    	steps {
    	   	 sh 'env | grep DOCKER'
    	      }
	}
    }
}
