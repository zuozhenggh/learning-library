. ./env.sh

# Install the scott schema
sqlplus $DB_ADMIN/$DB_PASSWD@$DB_TNS @dept.sql $DB_PASSWORD $DB_TNS