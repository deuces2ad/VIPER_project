import Foundation

class LandingRouter {
  
  init() {}
  
  func navigateToLogin() -> LoginView {
    let router = LoginRouter()
    let interactor = LoginInteractor()
    let presenter = LoginPresenter(interactor: interactor, router: router)
    return LoginView(loginPresenter: presenter, loginRouter: router)
  }
  
  func navigateToRegister() -> RegisterView {
    let router = RegisterRouter()
    let interactor = RegisterInteractor()
    let presenter = RegisterPresenter(interactor: interactor, router: router)
    return RegisterView(presenter: presenter, router: router)
  }
}
