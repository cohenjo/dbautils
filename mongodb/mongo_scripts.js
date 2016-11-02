function grep(list, val) {
     var regex = new RegExp(val);
     for( var i = 0; i < list.length; i++) {
        var elem = list[i];
        if(regex.test(elem)) {
			print(elem);	
		}	    
	 }
}

function grepJson(list, jsonPath, val) {
     var regex = new RegExp(val);
     for( var i = 0; i < list.length; i++) {
        var paths = jsonPath.split(".");        
        var elem = list[i]; 
        for(var j = 0; j < paths.length; j++) {     
           elem = elem[paths[j]];
        }
        
        if(regex.test(elem)) {
			print(elem);	
		}	    
	 }
}

function grepDbNamesByExp(expression) {
   var v = db.adminCommand('listDatabases');
   grepJson(v.databases, "name", expression);
}

function dropMultiTenantDbs() {
  var v = db.adminCommand('listDatabases');
  for(var i = 0 ; i < v.databases.length; i++) {
     var dbName = v.databases[i].name;
	 var hasNumbers = /\d/.test(dbName);
	 if(hasNumbers) {
	     var sdb = db.getSiblingDB(dbName);
		 print("Dropping db : " + dbName);
		 sdb.dropDatabase();
		 print("done");
	 }
  }
} 

function dropMTDbsByExpression(expression) {
  var v = db.adminCommand('listDatabases');
  var regex = new RegExp(expression);
  for(var i = 0 ; i < v.databases.length; i++) {
     var dbName = v.databases[i].name;
	 var hasNumbers = /\d/.test(dbName) && regex.test(dbName);
	 if(hasNumbers) {
	     var sdb = db.getSiblingDB(dbName);
		 print("Dropping db : " + dbName);
		 sdb.dropDatabase();
		 print("done");
	 }
  }
} 

function getIndexLength() {
   var dbNameLength = db.getName().length;
   var collectionsList = db.getCollectionNames();
   print(pad("Collection Name",50) + pad("Index Name", 50) + pad("Index Name", 25) + pad("Ind. + Col. Name", 25) + pad("Ind + Col. + DB. Name",25));print(repeat("-",175));   
   for(var i = 0; i < collectionsList.length; i++) {
       var colName = collectionsList[i];
	   var indexesJson = db.getCollection(colName).getIndexes();				 
	   for(var j = 0; j < indexesJson.length;j++) {
	       var indexName = indexesJson[j].name;
		   var indexNameLength = indexName.length;
		   var totalWithoutDbLength = indexNameLength + colName.length;
		   var total = dbNameLength + totalWithoutDbLength;
	       print(pad(colName, 50) + pad(indexName,50) + pad(indexNameLength,25) +pad(totalWithoutDbLength, 25) + pad(total,25) ); 
	   }	   
   }
}

function repeat(obj, times) {
   var res = "";
   for(var i = 0; i < times; i++) {
      res += obj;
   }
   return res;
}
function pad(obj, len) {
  var val = obj;
  if(typeof(obj) == "number") {
     val = obj.toString();
  }
  
  for(var i = len - val.length; i >=0 ;i--) {
    val += ' ';
  }
  return val;
}