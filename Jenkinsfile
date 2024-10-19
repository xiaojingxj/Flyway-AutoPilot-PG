pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository that contains Flyway migration scripts
                git url: 'https://github.com/xiaojingxj/Flyway-AutoPilot-PG', branch: 'main'
            }
        }
    
        stage('Apply Migration to Target DB (widgettest)') {
            steps {
                script {
                    // Use Jenkins credentials for PostgreSQL connection details
                    withCredentials([
                        string(credentialsId: 'FLYWAY_URL_WIDGETTEST', variable: 'FLYWAY_URL_WIDGETTEST'),
                        usernamePassword(credentialsId: 'FLYWAY_DB_CREDENTIALS', usernameVariable: 'FLYWAY_DB_USER', passwordVariable: 'FLYWAY_DB_PASSWORD')
                    ]) {
                        // Migrate changes on the widgettest database
                        sh """
                        /var/jenkins_home/flyway-10.20.0/flyway -url=$FLYWAY_URL_WIDGETTEST -user=$FLYWAY_DB_USER -password=$FLYWAY_DB_PASSWORD -locations=filesystem:./migrations migrate
                        """
                    }
                }
            }
        }

        stage('Clean Up') {
            steps {
                echo 'Migration completed successfully'
            }
        }
    }

    post {
        success {
            echo 'Database migration completed successfully.'
        }
        failure {
            echo 'Migration failed.'
        }
    }
}
