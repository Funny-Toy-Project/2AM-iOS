//
//  AuthService.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

import Foundation
import Alamofire

struct AuthService {
    static let shared = AuthService()
    
    // 로그인 통신에 대한 함수 정의
    func signIn(nickname: String,
                password: String,
                completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        // 현재 APIConstants 라는 구조체 내의 usersSignInURL 에 값이 있는 상태.
        let url = "http://52.79.159.200:8080/api/login"
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let body: Parameters = [
            "nickname" : nickname,
            "password" : password
        ]
        // 요청하기
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseJSON {(response) in
            print("response Data")
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                
                print("statusCode : \(statusCode)")
                print("statusCode Type : \(type(of: statusCode))")
                print("data : \(data)")
                print("data type : \(type(of: data))")
                // 응답 상태와 정보를 입력으로 하는 judgeSingInData 함수 실행
                
                let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: data)
                let dictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: dataExample) as? [String : Any]
                print("dataExample type : \(type(of: dataExample))")
                print("dataExample : \(dataExample)")
                print("dictionary : \(dictionary!)")
                
                completion(judgeSignInData(status: statusCode, data: data as! Data))
                
                
            case .failure(let err):
                print("failure: \(err)")
                completion(.networkFail)
            }
            
            
        }
    }
    // 상태에 따라 어떤 것을 출력해줄지 결정
    // 이 곳에 print문을 삽입해두면 어떤 문제 때문에 서버와 연결이 잘 안되고 있는지 알 수 있다.
    private func judgeSignInData(status: Int, data: Data) -> NetworkResult<Any> {
        
        // 우리가 원하는 형태로 디코딩 해준다.
        let decoder = JSONDecoder()
        
        
        guard let decodedData = try? decoder.decode(GenericResponse<LoginData>.self, from: data) else {
            return .pathErr
        }
        
        print("decodedData status : \(decodedData.status)")
        print("decodedData success : \(decodedData.success)")
        print("decodedData message : \(decodedData.message)")
        print("decodedData data : \(decodedData.data)")
        
        switch status {
        case 200:
            print("status 200 : \(decodedData.data!)")
            return .success(decodedData.data ?? "")
        case 400:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
}
