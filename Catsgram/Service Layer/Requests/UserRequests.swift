import Foundation

extension Notification.Name {
    static let signInNotification = Notification.Name("SignInNotification")
    static let signOutNofication = Notification.Name("SignOutNotification")
}

struct SignInUserRequest: APIRequest {
    let user: UserAuthentication

    init(username: String, password: String) {
        self.user = UserAuthentication(id: username, password: password)
    }

    typealias Response = Void

    var method: HTTPMethod { return .GET }
    var path: String { return "/user" }
    var body: Data? { return nil }

    func handle(rowResponse: Data) throws -> Void {
        currentUser = user
        NotificationCenter.default.post(name: .signInNotification, object: nil)
    }
}

struct SignUpUserRequest: APIRequest {
    let user: UserAuthentication

    init(username: String, email: String, password: String) {
        self.user = UserAuthentication(id: username, email: email, password: password)
    }

    typealias Response = Void

    var method: HTTPMethod { return .POST }
    var path: String { return "/user" }
    var body: Data? {
        return try? JSONEncoder().encode(user)
    }

    func handle(rowResponse: Data) throws -> Void {
        currentUser = user
        NotificationCenter.default.post(name: .signInNotification, object: nil)
    }
}
