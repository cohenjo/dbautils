var list = db.runCommand( { listDatabases: 1 } )
list.databases.forEach(function(dbdoc){
        if(dbdoc.empty != true){
                var d = db.getSisterDB(dbdoc.name);
                print("getting stats for: "+dbdoc.name );
                print("=======================================================");
                var colld = d.getCollectionNames();
                colld.forEach(function(name){
                        var col = d.getCollection(name);
                        print("col: "+ col.name + ", document count: " + col.stats(1024*1024*1024).size );
                        });
        }
}
);

use admin
var list = db.runCommand( { listDatabases: 1 } )
list.databases.forEach(function(dbdoc){
        if(dbdoc.empty != true){
                var d = db.getSisterDB(dbdoc.name);
                print("droping index for: "+dbdoc.name );
                print("=======================================================");
                d.WQContentDeploySampleContent.dropIndex("TS_PRI");
        }
}
);
