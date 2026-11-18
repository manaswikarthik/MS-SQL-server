// =====================================================
// LOGISTICS SHIPMENT ANALYTICS
// MongoDB Aggregation Project
// =====================================================

// Database
use("logistics_db");


// =====================================================
// TASK 1: SHIPMENTS WITH DELIVERY EVENTS
// =====================================================
// Business Question:
// Display every shipment along with its delivery tracking events.
//
// $lookup combines documents from shipments and delivery_events
// using shipment_id.

db.shipments.aggregate([
    {
        $lookup: {
            from: "delivery_events",
            localField: "shipment_id",
            foreignField: "shipment_id",
            as: "delivery_history"
        }
    }
]);


// =====================================================
// TASK 2: CUSTOMERS WITH THEIR SHIPMENTS
// =====================================================
// Business Question:
// Display each customer along with all shipments made by them.
//
// $lookup matches customers.customer_id with
// shipments.customer_id.

db.customers.aggregate([
    {
        $lookup: {
            from: "shipments",
            localField: "customer_id",
            foreignField: "customer_id",
            as: "shipment_history"
        }
    }
]);


// =====================================================
// TASK 3: CARRIERS WITH DELAY STATISTICS
// =====================================================
// Business Question:
// Calculate shipment count, average delay,
// and number of delayed shipments for each carrier.
//
// First, $lookup connects carriers with shipments.
// Then, $unwind separates the shipment array.
// Finally, $group calculates statistics.

db.carriers.aggregate([
    {
        $lookup: {
            from: "shipments",
            localField: "carrier_id",
            foreignField: "carrier_id",
            as: "carrier_shipments"
        }
    },
    {
        $unwind: "$carrier_shipments"
    },
    {
        $group: {
            _id: "$carrier_id",
            carrier_name: {
                $first: "$carrier_name"
            },
            total_shipments: {
                $sum: 1
            },
            average_delay: {
                $avg: "$carrier_shipments.delay_days"
            },
            delayed_shipments: {
                $sum: {
                    $cond: [
                        {
                            $gt: [
                                "$carrier_shipments.delay_days",
                                2
                            ]
                        },
                        1,
                        0
                    ]
                }
            }
        }
    },
    {
        $sort: {
            average_delay: -1
        }
    }
]);


// =====================================================
// CONCEPT: EMBEDDING VS $LOOKUP
// =====================================================
//
// $lookup:
// Used when related data is stored in separate collections.
// Example: shipments and delivery_events.
//
// Embedding:
// Better when related information is frequently accessed
// together and has a limited size.
//
// Example:
// A shipment document could contain its delivery events
// inside an embedded array.
//
// Embedding can reduce the need for joins, while $lookup
// provides flexibility when data is stored separately.
//
// =====================================================