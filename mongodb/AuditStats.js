rs.slaveOk()
use <tenant DB>
db.Audit.aggregate([{$match: {time: {$gte: 1468862166000}}},
                    { $project: { _id: 0,  component: 1, auditType: 1, resourceType: 1 } },
                    {$group:
                      {_id: {component: "$component",Ayupe: "$auditType", rType: "$resourceType"},
                       count: { $sum: 1 }
                      }
                    },
                    {$sort: {count: -1}},
                    {$limit: 100}
                  ])

                  // CPS
                  // ===
                  // "Workflow.TimerItem" -  147066
                  // "Workflow.TimerItem" -  146145
                  // "ems", "ADD_RELATION" -  107839
                  // "OpbAgentJSON" (update)- 76384
                  // "ems", (update)  -  57655
                  // "EMS Audit", "CREATE" - 32553
                  // "ems", (insert) - 32550
                  // "Favorites" (update) - 29909
                  // "Workflow.InactiveTimerItem" -  14841
                  // "ems",  "REMOVE_RELATION" -  10634
                  // "Workflow.InactiveTimerItem" -   8843
                  // "workflowPostCommitException" -  2323
                  //
                  //
                  // United
                  // =======
                  // "Workflow.TimerItem" - 592727
                  // "Workflow.TimerItem" - 579966
                  // "ems","UPDATE_ENTITY" - 457684
                  // "ems","ADD_RELATION" - 316413
                  // "Favorites" (update) - 122454
                  // "OpbAgentJSON" (update) - 76219
                  // "ems","REMOVE_RELATION" - 44150
