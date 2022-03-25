# Reports Builder tools
# https://docs.oracle.com/middleware/1221/formsandreports/install-fnr/install.htm#CIHBEADE
# http://dirknachbar.blogspot.com/2016/09/configure-jobstatusrepository-in-oracle.html
# https://www.oracle.com/technetwork/developer-tools/forms/documentation/formsreportsintegration-12c-3014203.pdf
#
# cd $ORACLE_HOME/oracle_common/common/bin/config.sh
# -> add the 
# Oracle Reports Application [reports]
# Oracle Reports Tools [ReportsToolComponent]
# Oracle Reports Server [ReportsServerComponent]

# Create the schema and table with the Reports Queue
cd $ORACLE_HOME/reports/admin/sql
sqlplus $DB_ADMIN/$DB_PASSWORD@$DB_TNS @$HOME/forms_samples/reports/reports.sql $DB_PASSWORD $DB_TNS
cd -

# Extend the Forms domain to add Reports. This will add 
# - WLS_REPORTS managed server
# - reportsTools
# - reportsServer
$ORACLE_HOME/oracle_common/common/bin/wlst.sh extend_domain_report.py

# Make reports cache
/u01/oracle/middleware/repcache

# Change the configuration
export REPORTS_CONFIG=$DOMAIN_HOME/config/fmwconfig/servers/WLS_REPORTS/applications/reports_12.2.1/configuration
cd $DOMAIN_HOME/config/fmwconfig/servers/WLS_REPORTS/applications/reports_12.2.1/configuration
cp $REPORTS_CONFIG/rwserver.conf $REPORTS_CONFIG/rwserver.conf.orig
cp rwserver.conf $REPORTS_CONFIG/.

# Add access to getserverinfo and showjobs via the URL
cp $REPORTS_CONFIG/rwserver.conf $REPORTS_CONFIG/rwserver.conf.orig
sed -i -e '\#<inprocess>#a <webcommandaccess>L2</webcommandaccess>' rwservlet.properties

# Sample
mkdir -p ${ORACLE_HOME}/reports/samples/demo
cp *.rdf ${ORACLE_HOME}/reports/samples/demo

# start the Reports Server
$DOMAIN_HOME/bin/startComponent.sh reportsServer

## Forms -> Repors
# Add COMPONENT_CONFIG_PATH to Forms Server (Allow Forms to call Reports)
echo "COMPONENT_CONFIG_PATH=$DOMAIN_HOME/config/fmwconfig/components/ReportsToolsComponent/reportsTools" >> $FORMS_CONFIG/default.env

# Test:
#
# http://localhost:9002/reports/rwservlet/getserverinfo?server=reportsServer
# http://localhost:9002/reports/rwservlet/showjobs?server=reportsServer
# http://localhost:9002/reports/rwservlet?server=reportsServer&module=test.rdf&destype=cache&desformat=html
# http://localhost:9002/reports/rwservlet?server=reportsServer&module=emp.rdf&destype=cache&desformat=html&userid=scott/LiveLab__123@orcl
#
# cd $DOMAIN_HOME/servers/reportsServer/logs/
# vi rwserver_diagnostic.log
# cd $DOMAIN_HOME/reports/bin
# ./rwdiag.sh -findall