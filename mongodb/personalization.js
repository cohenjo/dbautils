

// run on all DBS
use admin
var list = db.runCommand( { listDatabases: 1 } )
list.databases.forEach(function(dbdoc){
        if(dbdoc.empty != true){
                var d = db.getSisterDB(dbdoc.name);
                d.personalizationSetting.update({userSettings: {$not: {$elemMatch: {"key": "Homepage"}}}}  , { $addToSet: { userSettings:  {"key" : "Homepage", "value" : "\"platform_dashboard\""}}} , { multi: true })
        }
}
);


// Run on a single DB - all users
db.personalizationSetting.update({userSettings: {$not: {$elemMatch: {"key": "Homepage"}}}}  , { $addToSet: { userSettings:  {"key" : "Homepage", "value" : "\"platform_dashboard\""}}} , { multi: true })

// run on a specific User
db.personalizationSetting.update({"userId" : "10103"}  , { $addToSet: { userSettings:  {"key" : "Homepage", "value" : "\"platform_dashboard\""}}} , { multi: true })
