pipeline {
    agent any
    environment{   
        AWS_S3_BUCKET = "playdatenow"
        ARTIFACT_NAME = "hello-world.war"
        AWS_ACCESS_KEY_ID     = credentials('USER')
        AWS_SECRET_ACCESS_KEY = credentials('PASS')
        AWS_EB_APP_NAME = "hi"
        AWS_EB_APP_VERSION = "${BUILD_ID}"
        AWS_EB_ENVIRONMENT = "Hi-env"
    
    }

    stages {
        
        stage('quality scan'){
            steps{
                sh '''
            mvn clean verify sonar:sonar \
  -Dsonar.projectKey=online-Amjad-B2D2 \
  -Dsonar.host.url=http://52.23.193.18 \
  -Dsonar.login=sqp_18e8efb1dcbf32a0af39bc6d079337796e593148
                '''
            }
        }
   

        stage('Validate') {
            steps {
                sh "mvn validate"
                sh "mvn clean"
            }
        }

        stage('Build') {
            steps {
                sh "mvn compile"
            }
        }

        stage('Test') {
            steps {
                sh "mvn test"
                
            }
      
        }


        stage('Package') {
            steps {
                sh "mvn package"
                
            }
            post{
                success{
                    archiveArtifacts artifacts: '**/target/**.war', followSymlinks: false
                }
            
        }
        }
    
        stage('publish artfacts to s3') {
            steps {
                sh "aws configure set region us-east-1" 
                sh "aws s3 cp ./target/**.war s3://$AWS_S3_BUCKET/$ARTIFACT_NAME"
            }
        }
        
            stage('db') {
            steps {
                sh "mvn spring-boot:run"
                
            }
       
        }

        stage('Deploy') {
            steps {

                sh 'aws elasticbeanstalk create-application-version --application-name $AWS_EB_APP_NAME --version-label $AWS_EB_APP_VERSION --source-bundle S3Bucket=$AWS_S3_BUCKET,S3Key=$ARTIFACT_NAME'

                sh 'aws elasticbeanstalk update-environment --application-name $AWS_EB_APP_NAME --environment-name $AWS_EB_ENVIRONMENT --version-label $AWS_EB_APP_VERSION'
            }
        }

    
}
    }