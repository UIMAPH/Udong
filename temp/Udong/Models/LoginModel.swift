import Foundation


struct LoginResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
}

struct Result: Codable {
    let accessToken: String
    let refreshToken : String
}
