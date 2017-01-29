//mongo --eval "var vListOfDBs = \"shvartsg_v37_857561481_rms, MongoCleanUp,   shvartsg_v37_100000002_rms,shvartsg_v37_100000003_rms, shvartsg_v37_100000001_rms\"" /tmp/DropOldAuditCollection.js > /tmp/DropOldAuditCollection_`date +%d``date +%m``date +%y`_`date +%H``date +%M``date +%S`.out
//-------------------------------------------------------------------------
//var vListOfDBs = "shvartsg_v37_857561481_rms, shvartsg_v37_100000002_rms,shvartsg_v37_100000003_rms, shvartsg_v37_100000001_rms";
vListOfDBs = vListOfDBs.replace(/\s+/g, '');
//print(vListOfDBs);
vListOfDBs = vListOfDBs.split(",");
//print(vListOfDBs);
//var dbs = db.getMongo().getDBNames()
for(var i in vListOfDBs){
    db = db.getMongo().getDB( vListOfDBs[i] );
    print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
    if (db.Audit_old.findOne() != null)
    {
    	print( "Audit_old collection exists in " + db.getName() );
	db.Audit_old.drop();
    }
    else
    	print( "Collection doesn't exists in " + db.getName() );
}