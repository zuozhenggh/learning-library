# Reports Builder tools
# https://docs.oracle.com/middleware/1221/formsandreports/install-fnr/install.htm#CIHBEADE
# http://dirknachbar.blogspot.com/2016/09/configure-jobstatusrepository-in-oracle.html
#
# cd $ORACLE_HOME/oracle_common/common/bin/config.sh
# -> add the 
# Oracle Reports Application [reports]
# Oracle Reports Tools [ReportsToolComponent]
# Oracle Reports Server [ReportsServerComponent]

$ORACLE_HOME/oracle_common/common/bin/wlst.sh extend_domain_report.py

cd $ORACLE_HOME/reports/admin/sql
sqlplus $DB_ADMIN/$DB_PASSWD@$DB_TNS @$HOME/forms_samples/reports/reports.sql $DB_PASSWD $DB_TNS
cd -

# $DOMAIN_HOME/config/fmwconfig/servers/WLS_REPORTS/applications/reports_12.2.1/configuration/rwserver.conf