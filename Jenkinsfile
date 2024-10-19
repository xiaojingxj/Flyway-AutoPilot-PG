pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository that contains Flyway migration scripts
                git url: 'https://github.com/xiaojingxj/Flyway-AutoPilot-PG', branch: 'main'
                
            }
        }

        stage('Migrate from widgetdev to widgettest') {
            steps {
                script {
                    // Use Jenkins credentials for PostgreSQL connection details
                    withCredentials([
                        string(credentialsId: 'FLYWAY_URL_WIDGETDEV', variable: 'FLYWAY_URL_WIDGETDEV'),
                        string(credentialsId: 'FLYWAY_URL_WIDGETTEST', variable: 'FLYWAY_URL_WIDGETTEST'),
                        usernamePassword(credentialsId: 'FLYWAY_DB_CREDENTIALS', usernameVariable: 'FLYWAY_DB_USER', passwordVariable: 'FLYWAY_DB_PASSWORD')
                    ]) {
                        // First, migrate changes on the widgetdev database
                        sh """
                        flyway -url=$FLYWAY_URL_WIDGETDEV -user=$FLYWAY_DB_USER -password=$FLYWAY_DB_PASSWORD -locations=filesystem:./sql/migrations migrate
                        """

                        // Now, migrate changes on the widgettest database
                        sh """
                        flyway -url=$FLYWAY_URL_WIDGETTEST -user=$FLYWAY_DB_USER -password=$FLYWAY_DB_PASSWORD -locations=filesystem:./sql/migrations migrate
                        """
                    }
                }
            }
        }

        stage('Clean Up') {
            steps {
                echo "Migration completed successfully"
            }
        }
    }

    post {
        success {
            echo "Database migration completed successfully."
        }
        failure {
            echo "Database migration failed."
        }
    }
}
