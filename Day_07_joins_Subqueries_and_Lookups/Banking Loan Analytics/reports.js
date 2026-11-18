// ==========================================
// DAY 7 - BANKING LOAN ANALYTICS
// MongoDB Aggregation Reports
// ==========================================

// Select database
use banking_loan_analytics;


// ==========================================
// TASK 1: Loans with Customer Details
// ==========================================

db.loans.aggregate([
    {
        $lookup: {
            from: "customers",
            localField: "customer_id",
            foreignField: "customer_id",
            as: "customer_details"
        }
    },
    {
        $unwind: "$customer_details"
    },
    {
        $project: {
            _id: 0,
            loan_id: 1,
            loan_amount: 1,
            loan_status: 1,
            customer_name: "$customer_details.customer_name",
            customer_city: "$customer_details.city"
        }
    }
]);


// ==========================================
// TASK 2: Loans with Repayment History
// Calculate Total Repaid and Outstanding
// ==========================================

db.loans.aggregate([
    {
        $lookup: {
            from: "repayments",
            localField: "loan_id",
            foreignField: "loan_id",
            as: "repayment_history"
        }
    },
    {
        $addFields: {
            total_repaid: {
                $sum: "$repayment_history.repayment_amount"
            }
        }
    },
    {
        $addFields: {
            outstanding_amount: {
                $subtract: [
                    "$loan_amount",
                    "$total_repaid"
                ]
            }
        }
    },
    {
        $project: {
            _id: 0,
            loan_id: 1,
            customer_id: 1,
            loan_amount: 1,
            total_repaid: 1,
            outstanding_amount: 1,
            repayment_history: 1
        }
    }
]);


// ==========================================
// TASK 3: Latest Repayment for Each Loan
// Using $lookup Pipeline
// ==========================================

db.loans.aggregate([
    {
        $lookup: {
            from: "repayments",
            let: {
                loanId: "$loan_id"
            },
            pipeline: [
                {
                    $match: {
                        $expr: {
                            $eq: [
                                "$loan_id",
                                "$$loanId"
                            ]
                        }
                    }
                },
                {
                    $sort: {
                        repayment_date: -1
                    }
                },
                {
                    $limit: 1
                }
            ],
            as: "last_repayment"
        }
    },
    {
        $project: {
            _id: 0,
            loan_id: 1,
            customer_id: 1,
            loan_amount: 1,
            last_repayment_amount: {
                $arrayElemAt: [
                    "$last_repayment.repayment_amount",
                    0
                ]
            },
            last_repayment_date: {
                $arrayElemAt: [
                    "$last_repayment.repayment_date",
                    0
                ]
            }
        }
    }
]);