// ============================================================
// TELECOM USAGE AND BILLING REPORTS
// MongoDB Aggregation Project
// ============================================================

// Select database
use('TelecomUsageDB');

// ============================================================
// 1. CREATE COLLECTION AND INSERT SAMPLE DATA
// ============================================================

db.usage_events.drop();

db.usage_events.insertMany([
    {
        subscriber_id: "SUB001",
        plan_name: "5G Unlimited",
        circle: "Chennai",
        data_used_mb: 1500,
        session_duration_minutes: 45,
        event_timestamp: new Date("2026-11-01T08:00:00"),
        cell_tower: "TOWER_A"
    },
    {
        subscriber_id: "SUB002",
        plan_name: "4G Basic",
        circle: "Chennai",
        data_used_mb: 800,
        session_duration_minutes: 30,
        event_timestamp: new Date("2026-11-01T08:15:00"),
        cell_tower: "TOWER_A"
    },
    {
        subscriber_id: "SUB003",
        plan_name: "5G Unlimited",
        circle: "Bangalore",
        data_used_mb: 2500,
        session_duration_minutes: 60,
        event_timestamp: new Date("2026-11-01T09:00:00"),
        cell_tower: "TOWER_B"
    },
    {
        subscriber_id: "SUB004",
        plan_name: "4G Basic",
        circle: "Chennai",
        data_used_mb: 500,
        session_duration_minutes: 20,
        event_timestamp: new Date("2026-11-01T09:30:00"),
        cell_tower: "TOWER_A"
    },
    {
        subscriber_id: "SUB005",
        plan_name: "5G Unlimited",
        circle: "Hyderabad",
        data_used_mb: 3000,
        session_duration_minutes: 90,
        event_timestamp: new Date("2026-11-01T10:00:00"),
        cell_tower: "TOWER_C"
    },
    {
        subscriber_id: "SUB001",
        plan_name: "5G Unlimited",
        circle: "Chennai",
        data_used_mb: 2000,
        session_duration_minutes: 50,
        event_timestamp: new Date("2026-11-01T10:00:00"),
        cell_tower: "TOWER_A"
    },
    {
        subscriber_id: "SUB006",
        plan_name: "4G Premium",
        circle: "Bangalore",
        data_used_mb: 1200,
        session_duration_minutes: 35,
        event_timestamp: new Date("2026-11-01T11:00:00"),
        cell_tower: "TOWER_B"
    },
    {
        subscriber_id: "SUB002",
        plan_name: "4G Basic",
        circle: "Chennai",
        data_used_mb: 600,
        session_duration_minutes: 25,
        event_timestamp: new Date("2026-11-01T11:30:00"),
        cell_tower: "TOWER_A"
    },
    {
        subscriber_id: "SUB003",
        plan_name: "5G Unlimited",
        circle: "Bangalore",
        data_used_mb: 1800,
        session_duration_minutes: 40,
        event_timestamp: new Date("2026-11-01T12:00:00"),
        cell_tower: "TOWER_B"
    },
    {
        subscriber_id: "SUB007",
        plan_name: "4G Premium",
        circle: "Hyderabad",
        data_used_mb: 900,
        session_duration_minutes: 30,
        event_timestamp: new Date("2026-11-01T13:00:00"),
        cell_tower: "TOWER_C"
    },
    {
        subscriber_id: "SUB005",
        plan_name: "5G Unlimited",
        circle: "Hyderabad",
        data_used_mb: 2200,
        session_duration_minutes: 70,
        event_timestamp: new Date("2026-11-01T14:00:00"),
        cell_tower: "TOWER_C"
    },
    {
        subscriber_id: "SUB008",
        plan_name: "4G Basic",
        circle: "Chennai",
        data_used_mb: 400,
        session_duration_minutes: 15,
        event_timestamp: new Date("2026-11-01T15:00:00"),
        cell_tower: "TOWER_A"
    },
    {
        subscriber_id: "SUB009",
        plan_name: "5G Unlimited",
        circle: "Bangalore",
        data_used_mb: 3500,
        session_duration_minutes: 100,
        event_timestamp: new Date("2026-11-01T16:00:00"),
        cell_tower: "TOWER_B"
    },
    {
        subscriber_id: "SUB010",
        plan_name: "4G Premium",
        circle: "Hyderabad",
        data_used_mb: 1100,
        session_duration_minutes: 40,
        event_timestamp: new Date("2026-11-01T17:00:00"),
        cell_tower: "TOWER_C"
    },
    {
        subscriber_id: "SUB001",
        plan_name: "5G Unlimited",
        circle: "Chennai",
        data_used_mb: 1700,
        session_duration_minutes: 55,
        event_timestamp: new Date("2026-11-02T08:00:00"),
        cell_tower: "TOWER_A"
    },
    {
        subscriber_id: "SUB002",
        plan_name: "4G Basic",
        circle: "Chennai",
        data_used_mb: 700,
        session_duration_minutes: 28,
        event_timestamp: new Date("2026-11-02T09:00:00"),
        cell_tower: "TOWER_A"
    },
    {
        subscriber_id: "SUB003",
        plan_name: "5G Unlimited",
        circle: "Bangalore",
        data_used_mb: 2100,
        session_duration_minutes: 65,
        event_timestamp: new Date("2026-11-02T10:00:00"),
        cell_tower: "TOWER_B"
    },
    {
        subscriber_id: "SUB004",
        plan_name: "4G Basic",
        circle: "Chennai",
        data_used_mb: 550,
        session_duration_minutes: 22,
        event_timestamp: new Date("2026-11-02T11:00:00"),
        cell_tower: "TOWER_A"
    },
    {
        subscriber_id: "SUB005",
        plan_name: "5G Unlimited",
        circle: "Hyderabad",
        data_used_mb: 2800,
        session_duration_minutes: 85,
        event_timestamp: new Date("2026-11-02T12:00:00"),
        cell_tower: "TOWER_C"
    },
    {
        subscriber_id: "SUB006",
        plan_name: "4G Premium",
        circle: "Bangalore",
        data_used_mb: 1400,
        session_duration_minutes: 38,
        event_timestamp: new Date("2026-11-02T13:00:00"),
        cell_tower: "TOWER_B"
    }
]);

// Display inserted records
console.log("==================================================");
console.log("SAMPLE DATA INSERTED SUCCESSFULLY");
console.log("==================================================");

console.log("Total usage events:");
console.log(db.usage_events.countDocuments());


// ============================================================
// REPORT 1: HOURLY USAGE SUMMARY
// Purpose: Calculate total data usage and number of sessions
//         for every hour.
// ============================================================

console.log("\nREPORT 1: HOURLY USAGE SUMMARY");

db.usage_events.aggregate([
    {
        $group: {
            _id: {
                hour: {
                    $hour: "$event_timestamp"
                }
            },
            total_data_used_mb: {
                $sum: "$data_used_mb"
            },
            total_sessions: {
                $sum: 1
            },
            unique_subscribers: {
                $addToSet: "$subscriber_id"
            }
        }
    },
    {
        $project: {
            _id: 0,
            hour: "$_id.hour",
            total_data_used_mb: 1,
            total_sessions: 1,
            unique_subscriber_count: {
                $size: "$unique_subscribers"
            }
        }
    },
    {
        $sort: {
            hour: 1
        }
    }
]);


// ============================================================
// REPORT 2: AVERAGE SESSION LENGTH
// Purpose: Calculate average session duration for each plan.
// ============================================================

console.log("\nREPORT 2: AVERAGE SESSION LENGTH BY PLAN");

db.usage_events.aggregate([
    {
        $group: {
            _id: "$plan_name",
            total_sessions: {
                $sum: 1
            },
            total_session_minutes: {
                $sum: "$session_duration_minutes"
            },
            average_session_length: {
                $avg: "$session_duration_minutes"
            }
        }
    },
    {
        $project: {
            _id: 0,
            plan_name: "$_id",
            total_sessions: 1,
            total_session_minutes: 1,
            average_session_length: {
                $round: ["$average_session_length", 2]
            }
        }
    },
    {
        $sort: {
            average_session_length: -1
        }
    }
]);


// ============================================================
// REPORT 3: BUSIEST CELL TOWER
// Purpose: Identify the cell tower handling the highest number
//         of usage sessions and total data consumption.
// ============================================================

console.log("\nREPORT 3: BUSIEST CELL TOWER");

db.usage_events.aggregate([
    {
        $group: {
            _id: "$cell_tower",
            total_sessions: {
                $sum: 1
            },
            total_data_used_mb: {
                $sum: "$data_used_mb"
            },
            total_session_minutes: {
                $sum: "$session_duration_minutes"
            }
        }
    },
    {
        $project: {
            _id: 0,
            cell_tower: "$_id",
            total_sessions: 1,
            total_data_used_mb: 1,
            total_session_minutes: 1
        }
    },
    {
        $sort: {
            total_sessions: -1
        }
    },
    {
        $limit: 1
    }
]);


// ============================================================
// ADDITIONAL REPORT 4: DATA USAGE BY PLAN
// Purpose: Compare data consumption among subscription plans.
// ============================================================

console.log("\nREPORT 4: DATA USAGE BY PLAN");

db.usage_events.aggregate([
    {
        $group: {
            _id: "$plan_name",
            total_data_used_mb: {
                $sum: "$data_used_mb"
            },
            average_data_per_session: {
                $avg: "$data_used_mb"
            },
            session_count: {
                $sum: 1
            }
        }
    },
    {
        $project: {
            _id: 0,
            plan_name: "$_id",
            total_data_used_mb: 1,
            average_data_per_session: {
                $round: ["$average_data_per_session", 2]
            },
            session_count: 1
        }
    },
    {
        $sort: {
            total_data_used_mb: -1
        }
    }
]);


// ============================================================
// ADDITIONAL REPORT 5: SUBSCRIBER DATA CONSUMPTION
// Purpose: Identify subscribers with the highest data usage.
// ============================================================

console.log("\nREPORT 5: SUBSCRIBER DATA CONSUMPTION");

db.usage_events.aggregate([
    {
        $group: {
            _id: "$subscriber_id",
            total_data_used_mb: {
                $sum: "$data_used_mb"
            },
            total_sessions: {
                $sum: 1
            },
            total_session_minutes: {
                $sum: "$session_duration_minutes"
            }
        }
    },
    {
        $project: {
            _id: 0,
            subscriber_id: "$_id",
            total_data_used_mb: 1,
            total_sessions: 1,
            total_session_minutes: 1
        }
    },
    {
        $sort: {
            total_data_used_mb: -1
        }
    }
]);


// ============================================================
// ADDITIONAL REPORT 6: USAGE BY TELECOM CIRCLE
// Purpose: Compare data usage across geographical circles.
// ============================================================

console.log("\nREPORT 6: USAGE BY TELECOM CIRCLE");

db.usage_events.aggregate([
    {
        $group: {
            _id: "$circle",
            total_data_used_mb: {
                $sum: "$data_used_mb"
            },
            total_sessions: {
                $sum: 1
            },
            average_session_duration: {
                $avg: "$session_duration_minutes"
            }
        }
    },
    {
        $project: {
            _id: 0,
            circle: "$_id",
            total_data_used_mb: 1,
            total_sessions: 1,
            average_session_duration: {
                $round: ["$average_session_duration", 2]
            }
        }
    },
    {
        $sort: {
            total_data_used_mb: -1
        }
    }
]);


// ============================================================
// ADDITIONAL REPORT 7: DAILY USAGE SUMMARY
// Purpose: Calculate usage statistics for each day.
// ============================================================

console.log("\nREPORT 7: DAILY USAGE SUMMARY");

db.usage_events.aggregate([
    {
        $group: {
            _id: {
                year: {
                    $year: "$event_timestamp"
                },
                month: {
                    $month: "$event_timestamp"
                },
                day: {
                    $dayOfMonth: "$event_timestamp"
                }
            },
            total_data_used_mb: {
                $sum: "$data_used_mb"
            },
            total_sessions: {
                $sum: 1
            }
        }
    },
    {
        $project: {
            _id: 0,
            year: "$_id.year",
            month: "$_id.month",
            day: "$_id.day",
            total_data_used_mb: 1,
            total_sessions: 1
        }
    },
    {
        $sort: {
            year: 1,
            month: 1,
            day: 1
        }
    }
]);


// ============================================================
// ADDITIONAL REPORT 8: LONGEST SESSIONS
// Purpose: Find the top 5 longest usage sessions.
// ============================================================

console.log("\nREPORT 8: TOP 5 LONGEST SESSIONS");

db.usage_events.aggregate([
    {
        $sort: {
            session_duration_minutes: -1
        }
    },
    {
        $limit: 5
    },
    {
        $project: {
            _id: 0,
            subscriber_id: 1,
            plan_name: 1,
            session_duration_minutes: 1,
            data_used_mb: 1,
            cell_tower: 1,
            event_timestamp: 1
        }
    }
]);


// ============================================================
// END OF TELECOM USAGE AND BILLING REPORTS
// ============================================================

console.log("\n==================================================");
console.log("ALL REPORTS EXECUTED SUCCESSFULLY");
console.log("==================================================");