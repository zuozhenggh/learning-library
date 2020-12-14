#!/bin/sh
#
# Copyright (c) 2013, 2019, Oracle and/or its affiliates. All rights reserved.
#
# frmf2xml.sh - executable Bourne shell script to run Forms2XML
#               after setting up the required environment
#
# NOTE
#    The Forms installation process should replace
#    <percent>FORMS_ORACLE_HOME<percent> with the correct ORACLE_HOME
#    setting.  Please make these changes manually if not.
#

#
# Set ORACLE_HOME if not set in the calling environment:
#
ORACLE_HOME=/u01/oracle/middleware/Oracle_Home
export ORACLE_HOME

#
# Set config time JAVA_HOME as CT_JAVA_HOME 
#
CT_JAVA_HOME=/u01/oracle/jdk
export CT_JAVA_HOME

#
# Set O_JDK_HOME if not set in the calling environment:
# If O_JDK_HOME isn't set, try using JAVA_HOME; if that isn't set, then try
# looking in the Oracle_Home
#
O_JDK_HOME=${O_JDK_HOME:-${JAVA_HOME}}
O_JDK_HOME=${O_JDK_HOME:-${CT_JAVA_HOME}}
O_JDK_HOME=${O_JDK_HOME:-${ORACLE_HOME}/oracle_common/jdk}
export O_JDK_HOME

#
# Search path for Forms applications (.fmb &.fmx files, PL/SQL libraries)
# If you need to include more than one directory, they should be colon
# separated (e.g. /private/dir1:/private/dir2)
# Note: the current directory is always searched by default
#
FORMS_PATH=/u01/oracle/middleware/Oracle_Home/forms:/u01/oracle/middleware/user_projects/domains/base_domain/config/fmwconfig/components/FORMS/instances/forms1:/home/opc/oracle/formsmodules:/home/opc
export FORMS_PATH

#
# Java CLASSPATH for the XMLTOOLS.
# You can add to this path to make your own Java code available
#
#
# Java CLASSPATH for the XMLTOOLS.
# You can add to this path to make your own Java code available
#
FORMS_XMLTOOL_CLASSPATH=$ORACLE_HOME/jlib/frmjdapi.jar:$ORACLE_HOME/jlib/frmxmltools.jar:$ORACLE_HOME/oracle_common/modules/oracle.xdk/xmlparserv2.jar

#
# System settings
# ---------------
# You should not normally need to modify these settings.
#
if [ `uname -s` = 'SunOS' ] && [ `uname -p` = 'sparc' ]; then
    LD_LIBRARY_PATH=$ORACLE_HOME/lib:$O_JDK_HOME/jre/lib/sparcv9/server:$O_JDK_HOME/jre/lib/sparcv9/native_threads:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH
elif [ `uname -s` = 'SunOS' ] && [ `uname -p` = 'i386' ]; then
    LD_LIBRARY_PATH=$ORACLE_HOME/lib:$O_JDK_HOME/jre/lib/amd64/server:$O_JDK_HOME/jre/lib/amd64/native_threads:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH
elif [ `uname -s` = 'HP-UX' ] && [ `uname -m` = 'ia64' ]; then
    LD_LIBRARY_PATH=$ORACLE_HOME/lib:$O_JDK_HOME/jre/lib/IA64W:$O_JDK_HOME/jre/lib/IA64W/server:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH
elif [ `uname -s` = 'HP-UX' ]; then
    SHLIB_PATH=$ORACLE_HOME/lib:$O_JDK_HOME/jre/lib/PA_RISC2.0W:$O_JDK_HOME/jre/lib/PA_RISC2.0W/server:$O_JDK_HOME/jre/lib/PA_RISC2.0W/native_threads:$SHLIB_PATH
    export SHLIB_PATH
elif [ `uname -s` = 'AIX' ]; then
    LIBPATH=$ORACLE_HOME/lib:$O_JDK_HOME/jre/bin:$O_JDK_HOME/jre/bin/classic:$LIBPATH
    export LIBPATH
    # Init the API without Motif:
    FORMS_API_TK_BYPASS=TRUE
    export FORMS_API_TK_BYPASS
elif [ `uname -s` = 'Linux' ] && [ `uname -m` = 'x86_64' ]; then
    LD_LIBRARY_PATH=$O_JDK_HOME/jre/lib/amd64/native_threads:$O_JDK_HOME/jre/lib/amd64/server:$O_JDK_HOME/jre/lib/amd64:$ORACLE_HOME/lib
    export LD_LIBRARY_PATH
else
    echo "Platform you are using is not supported currently."
    exit 1
fi

# Include -d64 for hybrid platforms
if [ `uname -s` = 'HP-UX' ] || [ `uname -s` = 'SunOS' ]; then
    $O_JDK_HOME/bin/java -d64 -classpath $FORMS_XMLTOOL_CLASSPATH oracle.forms.util.xmltools.Forms2XML "$@"
else
    $O_JDK_HOME/bin/java -classpath $FORMS_XMLTOOL_CLASSPATH oracle.forms.util.xmltools.Forms2XML "$@"
fi 