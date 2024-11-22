import Foundation

protocol RegisterInteractorProtocol {
  func registerNewUser()
}

class RegisterInteractor: RegisterInteractorProtocol {
  
  func registerNewUser() {
    print("Registering user....")
  }
  
}
