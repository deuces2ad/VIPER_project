import Foundation

protocol LoginRouterProtocol {
  func navigateToHome()
  var isLoggedIn: Bool { get set }
}

class LoginRouter: LoginRouterProtocol, ObservableObject {
  
  @Published
  var isLoggedIn: Bool = false
  
  func navigateToHome() {
    isLoggedIn = true
  }
}

