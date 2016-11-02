var o = db.Audit.find({component:"ems"}).limit(5);
o.forEach(function(obj) {
    var row = '';
    row += obj.entityId+',-1,';
    row += (obj.relatedEntityId === undefined ) ? ',' : obj.relatedEntityId +',';
    row += (obj.relationshipName === undefined ) ? ',' : '"'+obj.relatedEntityId+'",';
    row += '"'+obj.entityType+'",';
    row += (obj.emsHistoryChangeType === undefined ) ? 'null,' : '"'+obj.emsHistoryChangeType +'",';
    var keys = []
    for (key in obj.changeProperties) keys.push(key);
    row += '"{'+keys.join(',')+'}",';
    row += '"'+tojson(obj.changeProperties).replace(/NumberLong\("(\d+)"\)/gm,'$1').replace(/(\r\n|\n|\r|\s)/gm,'').replace(/"/gm,'""')+'",';
    row += obj.time+',';
    row += '"'+obj.outcome+'",';
    row += '"'+obj.userId+'",';
    row += '"'+obj.userName+'",';
    row += '"'+obj.sourceIp+'",';
    row += '"16.60.17.128",';
    row += '"'+obj.actUserId+'",';
    row += '"'+obj.actUserName+'"';
    print(row);   
    })

    
  