import Foundation
import KituraContracts

var currentUser: UserAuthentication?

struct UserAuthentication: Codable {
    var id: String
    var email: String?
    var password: String?
}

struct UserParams: QueryParams {
    var id: String
    var password: String
}
