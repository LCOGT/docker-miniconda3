#!/usr/bin/env groovy

@Library('lco-shared-libs@0.0.1') _

pipeline {
	agent any
	environment {
		dockerImage = null
		PROJ_NAME = projName("${JOB_NAME}")
		GIT_DESCRIPTION = gitDescription()
		DOCKER_IMG = dockerImageName("${LCO_DOCK_REG}", "${PROJ_NAME}", "${GIT_DESCRIPTION}")
	}
	stages {
		stage('Build image') {
			steps {
				script {
					dockerImage = docker.build("${DOCKER_IMG}")
				}
			}
		}
		stage('Push image') {
			steps {
				script {
					dockerImage.push("${GIT_DESCRIPTION}")
				}
			}
		}
	}
}
