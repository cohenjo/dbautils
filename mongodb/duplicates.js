db.Audit.aggregate([
  { $match: {'component':'ems'}},
  { $group: { _id: {entityId: "$entityId",entityType:"$entityType", time:"$time",correlationId:"$correlationId"} ,    uniqueIds: { $addToSet: "$_id" },
    count: { $sum: 1 } 
  } }, 		
  { $match: { 
    count: { $gte: 2 } 
  } },
  { $sort : { count : -1} },
  { $limit : 10 }
]);

  
