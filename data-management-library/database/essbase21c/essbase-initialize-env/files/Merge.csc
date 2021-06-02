set updatecalc off;
SET CREATENONMISSINGBLK ON;
SET RUNTIMESUBVARS {


Product   = APP <RTSV_HINT><svLaunch>
<description>Product to Copy</description>
<type>member</type>
<allowMissing>false</allowMissing>
<dimension>Products</dimension>
<choice>single</choice>
</svLaunch></RTSV_HINT>;

Customer =   Customer <RTSV_HINT><svLaunch>
<description>Customer to merge</description>
<type>member</type> 
<allowMissing>false</allowMissing>
<dimension>Customer</dimension>
<choice>single</choice>
</svLaunch></RTSV_HINT>;

Region =   Regions <RTSV_HINT><svLaunch>
<description>Region to merge</description>
<type>member</type> 
<allowMissing>false</allowMissing>
<dimension>Regions</dimension>
<choice>single</choice>
</svLaunch></RTSV_HINT>;

Time =   Time <RTSV_HINT><svLaunch>
<description>Periods to merge</description>
<type>member</type> 
<allowMissing>false</allowMissing>
<dimension>Time</dimension>
<choice>multiple</choice>
</svLaunch></RTSV_HINT>;

Scenario =   POV <RTSV_HINT><svLaunch>
<description>Sandbox to merge</description>
<type>member</type> 
<allowMissing>false</allowMissing>
<dimension>Sandbox</dimension>
<choice>single</choice>
</svLaunch></RTSV_HINT>;
};


Fix(@Relative(&Product,0), @Relative(&Customer,0), @Relative(&Region,0), &Time)
	DataMerge &Scenario base;
EndFix
