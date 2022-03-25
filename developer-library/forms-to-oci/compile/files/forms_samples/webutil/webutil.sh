# Note: the DB_USER schema has to exists before to run this command.

# install the DB part of Webutil
sqlplus $DB_USER/$DB_PASSWORD@$DB_TNS @$ORACLE_HOME/forms/create_webutil_db.sql

cd /tmp
# Download jacob.jar and dlls
wget https://github.com/freemansoft/jacob-project/releases/download/Root_B-1_20/jacob-1.20.zip
unzip jacob-1.20.zip 
cp jacob-1.20/jacob-1.20-x86.dll $ORACLE_HOME/forms/webutil/win32/.
cp jacob-1.20/jacob-1.20-x64.dll $ORACLE_HOME/forms/webutil/win64/.
cp jacob-1.20/jacob.jar $ORACLE_HOME/forms/java/.
# Modify webutil.cfg for 1.20 version
cd $FORMS_INSTANCE/server
cp webutil.cfg webutil.cfg.orig
sed -i 's#jacob-1.18-M2-x86.dll|167424|1.18-M2#jacob-1.20-x86.dll|189440|1.20>#g' webutil.cfg
sed -i 's#jacob-1.18-M2-x64.dll|204800|1.18-M2#jacob-1.20-x64.dll|226816|1.20>#g' webutil.cfg
diff webutil.cfg webutil.cfg.orig

# Sign the jacob.jar file
cd $ORACLE_HOME/forms/java
cp jacob.jar jacob.jar.unsigned
# Create a selfsigned keystore if it does not exist
export KEYSTORE=/u01/oracle/selfsigned.jks
if [ ! -f "$KEYSTORE" ]; then
  keytool -genkeypair -alias selfAlias -keystore $KEYSTORE -validity 3650 -dname "CN=orablog.org, OU=ID, O=demo, L=demo, S=demo, C=BE" -storepass changeit -keypass changeit -noprompt
  keytool -export -keystore $KEYSTORE -storepass changeit -alias selfAlias -file /mnt/software/share/selfAlias.cer
fi
jarsigner -keystore $KEYSTORE -storepass changeit jacob.jar selfAlias

# extension.jnlp
cp extensions.jnlp extensions.jnlp.orig
sed -i 's#<!-- <jar href="jacob.jar"/> -->#<jar href="jacob.jar"/>#g' extensions.jnlp
diff extensions.jnlp extensions.jnlp.orig
# To make it work, there are additional steps needed:
# - Or go in the java console tab security and add https://url.that.you.use.to.access.forms/ (ex http://localhost:9001) in the list of exceptions 
# - Or import /u01/oracle/selfAlias.cer in java console tab security
# Ideally, it would be nice to create a certificate (with let's encrypt?) and use it to sign instead

# Copy the Webutil.pll and .olb the formmodule directory to compile it 
# and move the one from $ORACLE_HOME/forms to avoid using wrong library.
mkdir $ORACLE_HOME/forms/orig
cp $ORACLE_HOME/forms/webutil.* $HOME/oracle/formsmodules
mv $ORACLE_HOME/forms/webutil.* $ORACLE_HOME/forms/orig/webutil.*

