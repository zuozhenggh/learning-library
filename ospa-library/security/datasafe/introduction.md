# Securing your Databases with Data Safe

Data Safe is a unified control center for your Oracle Databases which helps you understand the sensitivity of your data, evaluate risks to data, mask sensitive data, implement and monitor security controls, assess user security, monitor user activity, and address data security compliance requirements.
As part of this lab, you will be able to navigate Data Safe console and monitor databases.

Data Safe is created with users and roles that will allow for a a couple of the features to collect the audit logs and perform a database assessment. The user is `DS\$ADMIN` and roles are `DS\$AUDIT_COLLECTION_ROLE` and `DS\$ASSESSMENT_ROLE`. This is based on least privileges and additional roles such as `DS\$DATA_DISCOVERY_ROLE` and `DS\$DATA_MASKING_ROLE` roles can be added to perform data masking operations.
