import UIKit
import Foundation
import Security
import Alamofire
import UIKit


struct BadgeService{
    static let shared = BadgeService()
    
    private func makeParameter(accessToken : String) -> Parameters {
        return Parameters()
    }
    
    func loadBadge(completion : @escaping (NetworkResult<Any>) -> Void)
    {
        let url: String = APIConstants.baseURL + APIConstants.badgeURL
        let header : HTTPHeaders = NetworkInfo.headerWithToken
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: nil,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure: completion(.pathErr)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(NetkResponseWithArray<BadgeModel>.self, from: data)
        else {
            return .pathErr}
        switch statusCode {
        case 200: return .success(decodedData)
        case 400: return .requestErr(decodedData)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
