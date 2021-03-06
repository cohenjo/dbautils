//mongo --eval "var vListOfDBs = \"shvartsg_v37_857561481_rms, MongoCleanUp,   shvartsg_v37_100000002_rms,shvartsg_v37_100000003_rms, shvartsg_v37_100000001_rms\"" /tmp/MoveAuditDataToNewCollection.js > /tmp/MoveAuditDataToNewCollection_`date +%d``date +%m``date +%y`_`date +%H``date +%M``date +%S`.out
function MoveAuditDataToNewCollection(db_name){

	var strMessages;
	var current_date;
	
	db = db.getMongo().getDB( db_name );
	
	current_date = new Date();
	print(">>> Start Moving for: db_name = " + db_name + " ;date = " + current_date);
	strMessages = ">>> Start Moving for: db_name = " + db_name + " ;date = " + current_date + "\n";
 
	var v_status = db.Audit.renameCollection("Audit_old");
	
	if (v_status.ok == 1)
	{
		current_date = new Date();
		print(">>> Audit in " + db.getName() + " renamed to Audit_old is successful" + current_date);
		strMessages = strMessages + ">>> Audit in " + db.getName() + " renamed to Audit_old is successful" + current_date + "\n";
	}
	else 
	{
		print( ">>> ERROR: Audit in " + db.getName() + " renamed to Audit_old is failed with Monogo error: '" + v_status.errmsg + "'" );
		strMessages = strMessages + ">>>>> ERROR: Audit in " + db.getName() + " renamed to Audit_old is failed with Monogo error: '" + v_status.errmsg + "'\n";
		db.getSiblingDB("MongoCleanUp").runCommand({insert:"Logs",documents:[{database:db_name, msg:strMessages, time:current_date, status:"FAILURE"}]});
		return;
	}

	//Audit is target
	var bulkInsert = db.Audit.initializeUnorderedBulkOp();
	//Audit_old is source
	var BulkSize = 10000;
	var counter = 0;	
	var start_date = new Date();
	db.Audit_old.find({$and: [{component:{ $ne: "ems" }}, {resourceType:{$nin: ["Workflow.TimerItem","Workflow.InactiveTimerItem","OpbAgentJSON"]}} ]}).sort({time:1}).forEach(
	    function(doc){
	      bulkInsert.insert(doc);
	      counter ++;
	      if( counter % BulkSize == 0){
	       	last_time = doc.time;
	      	//print(">>>>> DEBUG: last_time = " + last_time + ";     last_time = " + (new Date(last_time)));
	      	//printing part of bulks in case of small BulkSize:
	       	if(counter % 10000 == 0)
	       	{
	       		current_date = new Date();
			print(">>> counter = " + counter + ";     last_time = " + last_time + ";     last_time = " + (new Date(last_time)) + ";     current datetime: " + current_date);
			strMessages = strMessages + ">>> counter = " + counter + ";     last_time = " + last_time + ";     last_time = " + (new Date(last_time)) + ";     current datetime: " + current_date + "\n";
		}
	      	//debugging "print" taking much time:
	      	//print(">>>>> DEBUG: The amount of data to be moved is " + db.Audit_old.find({"time":{$gt: date.getTime()}}).count());
	       	bulkInsert.execute();
	        bulkInsert = db.Audit.initializeUnorderedBulkOp();
	      }
	    }
	  )
	bulkInsert.execute();
	//to measure time finally
	current_date = new Date();
	print(">>>>>>>>> bulk inserts by " + BulkSize + " for " + db.getName() + " of " + counter + " takes: " + (current_date-start_date));
	strMessages = strMessages + ">>>>>>>>> bulk inserts by " + BulkSize + " for " + db.getName() + " of " + counter + " takes: " + (current_date-start_date) + "\n";
	
	//db.Audit.count();
	db.runCommand(
	  {
	    createIndexes: "Audit",
	    indexes: [
		{key:{"userId":1},"name":"USERID_IDX",background: true},
		{key:{"auditType":1},"name":"AUDITTYPE_IDX",background: true},
		{key:{"time":1},"name":"TIME_IDX",background: true},
		{key:{"component":1},"name":"COMPONENT_IDX",background: true},
		{key:{"sourceIp":1},"name":"SOURCE_IP_IDX",background: true},
		{key:{"correlationId":1},"name":"CORRELATION_ID_IDX",background: true}
	    ]
	  }
	);
	current_date = new Date();
	print (">>>>>>>>> total time (including indexing) by " + BulkSize + " for " + db.getName() + " of " + counter + " takes: " + (current_date-start_date));
	strMessages = strMessages + ">>>>>>>>> total time (including indexing) by " + BulkSize + " for " + db.getName() + " of " + counter + " takes: " + (current_date-start_date) + "\n";
	print("------------------------------------------------------------------------------------------");
	db.getSiblingDB("MongoCleanUp").runCommand({insert:"Logs",documents:[{database:db_name, msg:strMessages, time:current_date, status:"PASS"}]});
}


//calling the function for specific database: MoveAuditDataToNewCollection('<db_name>', -1);
//var vListOfDBs = "shvartsg_v37_857561481_rms, MongoCleanUp,   shvartsg_v37_100000002_rms,shvartsg_v37_100000003_rms, shvartsg_v37_100000001_rms";
vListOfDBs = vListOfDBs.replace(/\s+/g, '');
//print(vListOfDBs);
vListOfDBs = vListOfDBs.split(",");
//print(vListOfDBs);
//var dbs = db.getMongo().getDBNames()
for(var i in vListOfDBs){
    db = db.getMongo().getDB( vListOfDBs[i] );
    print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
    //existing Audit collection could be checked by
    //if (db.Audit.count() > 0)
    //or by (with better performance):
    if (db.Audit.findOne() != null)
    {
    	print( "Audit collection exists in " + db.getName() );
	MoveAuditDataToNewCollection(db.getName());
    }
    else
    {
    	print( "ERROR: Collection doesn't exists in " + db.getName() );
    	db.getSiblingDB("MongoCleanUp").runCommand({insert:"Logs",documents:[{database:db.getName(), msg:"ERROR: Collection doesn't exists in " + db.getName(), time:new Date(), status:"FAILURE"}]});
    }
}
