// ==========================================
// SET 3 - RETAIL RETURNS AND REFUNDS
// MongoDB Aggregation Reports using $lookup
// ==========================================

// ==========================================
// REPORT 1: Returns + Customers + Products
// ==========================================

db.returns.aggregate([
    {
        $lookup: {
            from: "customers",
            localField: "customer_id",
            foreignField: "customer_id",
            as: "customer_details"
        }
    },
    {
        $lookup: {
            from: "products",
            localField: "product_id",
            foreignField: "product_id",
            as: "product_details"
        }
    },
    {
        $unwind: "$customer_details"
    },
    {
        $unwind: "$product_details"
    },
    {
        $project: {
            _id: 0,
            return_id: 1,
            customer_name: "$customer_details.customer_name",
            product_name: "$product_details.product_name",
            category: "$product_details.category",
            return_reason: 1,
            return_date: 1
        }
    }
]);


// ==========================================
// REPORT 2: Returns + Refunds + Products
// ==========================================

db.returns.aggregate([
    {
        $lookup: {
            from: "refunds",
            localField: "return_id",
            foreignField: "return_id",
            as: "refund_details"
        }
    },
    {
        $lookup: {
            from: "products",
            localField: "product_id",
            foreignField: "product_id",
            as: "product_details"
        }
    },
    {
        $unwind: "$refund_details"
    },
    {
        $unwind: "$product_details"
    },
    {
        $project: {
            _id: 0,
            return_id: 1,
            product_name: "$product_details.product_name",
            return_reason: 1,
            refund_amount: "$refund_details.refund_amount",
            refund_status: "$refund_details.refund_status"
        }
    }
]);


// ==========================================
// REPORT 3: Returns + Customer Feedback
// ==========================================

db.returns.aggregate([
    {
        $lookup: {
            from: "return_feedback",
            localField: "return_id",
            foreignField: "return_id",
            as: "feedback_details"
        }
    },
    {
        $lookup: {
            from: "customers",
            localField: "customer_id",
            foreignField: "customer_id",
            as: "customer_details"
        }
    },
    {
        $unwind: "$feedback_details"
    },
    {
        $unwind: "$customer_details"
    },
    {
        $project: {
            _id: 0,
            return_id: 1,
            customer_name: "$customer_details.customer_name",
            return_reason: 1,
            feedback: "$feedback_details.feedback",
            rating: "$feedback_details.rating",
            feedback_date: "$feedback_details.feedback_date"
        }
    }
]);