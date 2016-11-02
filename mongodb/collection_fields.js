isNumberLong = function(arr){
   return arr != undefined && arr.constructor == NumberLong
};

isObjectId = function(arr){
   return arr != undefined && arr.constructor == ObjectId
};

report_keys = function(o){
    a = Object.keySet(o);
    r = '               ';
    for (k in a) r +=','+a[k];
    return r; 
};

var colld = db.getCollectionNames();
colld.forEach(function(name){
    col = db.getCollection(name);
    keys = {};    
    docs = col.find().limit(2);
    docs.forEach(function(doc){ for (key in doc) keys[key]=doc[key];    });    
    print("=======================================================");
    print("col: "+ col + ", document keys: ");    

    for (key in keys) 
        {
            print(key+':');
            if (isObjectId(keys[key])) print("   object ID");
            else if (Array.isArray(keys[key])) print("   array");
            else if (isNumberLong(keys[key]) ) print("   NumberLong");
            else if (typeof(keys[key])=='object'){
                //print(Object.keySet(keys[key]));
                print(report_keys(keys[key]));
            }
            else  print(typeof(keys[key])+':'+keys[key]+',');
        }
    print("=======================================================");
});


