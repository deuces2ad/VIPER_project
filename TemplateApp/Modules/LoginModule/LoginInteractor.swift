import Foundation

protocol LoginInteractorProtocol {
  func authenticateUser(with loginCredential: LoginCredential) -> UserInfo?
}

struct LoginInteractor: LoginInteractorProtocol {
  
  private var apiService: APIServiceCompositeProtocol
  
  init(apiService: APIServiceCompositeProtocol = APIService.shared) {
    self.apiService = apiService
  }
  
  func authenticateUser(with loginCredential:LoginCredential) -> UserInfo? {
    apiService.login(using: loginCredential) { result in
      switch result {
      case .success(let result):
        print(result,"111")
      case .failure(let error):
        print(error)
      }
    }
    
    let user = UserInfo(firstName: "Abhishek", lastName: "s")
    return user
  }
}

struct LoginCredential: Encodable {
  let email, password: String
}

struct UserInfo: Codable {
  let firstName, lastName: String?
}
