import Foundation

var currentUser: UserAuthentication?

struct UserAuthentication: Codable {
    var id: String
    var email: String?
    var password: String?
}
