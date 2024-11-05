import Foundation

struct Customer {
    let id: Int
    var name: String
    var age: Int
    var email: String
}

struct Policy {
    let id: Int
    let customer_id: Int
    var policyType: String
    var premiumAmount: Double
    var startDate: String
    var endDate: String
}

struct Claim {
    let id: Int
    let customer_id: Int
    let policyId: Int
    var claimAmount: Double
    var dateOfClaim: String
    var status: String
}

struct Payment {
    let id: Int
    var name: String
}

class SharedData {
    static let shared = SharedData()
    var customers: [Customer] = []
    var policies: [Policy] = []
    var claims: [Claim] = []
    var payments: [Payment] = []
    var customerPoliciesDict: [Int: [Policy]] = [:]
}


//import Foundation
//
//struct Customer {
//    let id: Int
//    var name: String
//    var age: Int
//    var email: String
//}
//
//struct InsurancePolicy {
//    let id: Int
//    let customerId: Int
//    var policyType: String
//    var premiumAmount: Double
//    var startDate: String
//    var endDate: String
//}
//

//
//struct Payment {
//    let id: Int
//    let policyId: Int
//    var paymentAmount: Double
//    var paymentDate: String
//    var paymentMethod: String
//    var status: String
//}
//
//class SharedData {
//    static let shared = SharedData()
//    var customers: [Customer] = []
//    var policies: [InsurancePolicy] = []
//    var claims: [Claim] = []
//    var payments: [Payment] = []
//}
