//import UIKit
//import Foundation
//import Security
//import Alamofire
//import UIKit
//
//
//struct LoginService{
//    static let shared = LoginService()
//    
//    private func makeParameter(accessToken : String) -> Parameters {
//        return ["accessToken" : accessToken]
//    }
//    
//    func loadProfile(completion : @escaping (NetworkResult<Any>) -> Void)
//    {
//        let url: String = APIConstants.loginURL
//        let header : HTTPHeaders = NetworkInfo.headerWithToken
//        let dataRequest = AF.request(url,
//                                     method: .post,
//                                     parameters: makeParameter(accessToken: accessToken),
//                                     encoding: JSONEncoding.default,
//                                     headers: header)
//        dataRequest.responseData { dataResponse in
//            switch dataResponse.result {
//            case .success:
//                guard let statusCode = dataResponse.response?.statusCode else {return}
//                guard let value = dataResponse.value else {return}
//                let networkResult = self.judgeStatus(by: statusCode, value)
//                completion(networkResult)
//            case .failure: completion(.pathErr)
//            }
//        }
//        
//    }
//    
//    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
//        let decoder = JSONDecoder()
//        guard let decodedData = try? decoder.decode(LoginResponse.self, from: data)
//        else {
//            print("-----------------------------------cutecute")
//            return .pathErr}
//        switch statusCode {
//        case 200: return .success(decodedData)
//        case 400: return .requestErr(decodedData)
//        case 500: return .serverErr
//        default: return .networkFail
//        }
//    }
//}
//
//struct SocialLogin: Codable {
//    let oauthID: String
//
//    enum CodingKeys: String, CodingKey {
//        case oauthID
//    }
//}
