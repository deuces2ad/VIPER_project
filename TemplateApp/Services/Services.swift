import Foundation


protocol LoginInService {
  func login(using credentials: LoginCredential, completion: @escaping (Result<UserInfo, Error>) -> Void)
}


extension APIService: LoginInService {
    public func login(using credentials: LoginCredential, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        sendRequest(
            endpoint: "https://your-project-id.mockapi.io/api/v1/users",
            method: .post,
            parameters: credentials,
            headers: ["Content-Type": "application/json"],
            decodingType: UserInfo.self
        ) { result in
            switch result {
            case .success(let userInfo):
                completion(.success(userInfo))
            case .failure(let error):
              completion(.failure(error))
            }
        }
    }
}

extension APIService: APIServiceCompositeProtocol { }

protocol APIServiceCompositeProtocol: APIServiceProtocol, LoginInService, ExerciseService {}
