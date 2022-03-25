# extend_domain_reports.py
readDomain('/u01/oracle/middleware/user_projects/domains/base_domain')
selectTemplate('Oracle Reports Application')
selectTemplate('Oracle Reports Server')
loadTemplates()
updateDomain()
closeDomain()
# create an instance of reptools1 and rep_server1
createReportsToolsInstance(instanceName='reportsTools',machine='AdminServerMachine')
createReportsServerInstance(instanceName='reportsServer',machine='AdminServerMachine')

# create a credential for the password of the RWADMIN database user (with the Reports queue tables)
v_dbPwd=os.environ['DB_PASSWORD']
v_wlsPwd=os.environ['WLS_PASSWORD']
connect("weblogic",v_wlsPwd)
createCred(map="reports", key="reports_repository", user="rwadmin", password=v_dbPwd)
exit()

