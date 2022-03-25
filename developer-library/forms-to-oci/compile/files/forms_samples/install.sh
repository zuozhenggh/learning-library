. ./env.sh

# Install the scott schema
sqlplus $DB_ADMIN/$DB_PASSWORD@$DB_TNS @dept.sql $DB_PASSWORD $DB_TNS

# Add the sample to formsweb.cfg
cat formsweb.cfg.template >> $FORMS_CONFIG/formsweb.cfg
mv formsweb.cfg.template formsweb.cfg.template.done

# Install WebUtil
webutil/webutil.sh

# Compile
./compile.sh
