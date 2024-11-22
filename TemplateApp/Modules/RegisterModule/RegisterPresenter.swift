import Foundation

protocol RegisterPresenterProtocol: ObservableObject {
  var name: String { get set }
  var email: String { get set }
  var password: String { get set }
  var isTermsAndConditionsChecked: Bool { get set }
  var error: String? { get set }
  func completeRegistration()
}

class RegisterPresenter: RegisterPresenterProtocol {
  
  @Published
  var name: String = ""
  
  @Published
  var email: String = ""
  
  @Published
  var password: String = ""
  
  @Published
  var error: String?
  
  @Published
  var isTermsAndConditionsChecked: Bool = false
  
  private var interactor: RegisterInteractorProtocol
  private var validation: LoginValidation
  private var router: RegisterRouter
  
  init(interactor: RegisterInteractorProtocol, validation: LoginValidation = .init(), router: RegisterRouter) {
    self.interactor = interactor
    self.validation = validation
    self.router = router
  }
  
  func completeRegistration() {
    
    if !validation.validateEmail(with: email) {
      error = "Please enter a valid email address"
      return
    }
    if checkTermsAndConditions() {
      interactor.registerNewUser()
      router.isRegistrationComplete = true
    }
  }
  
  private func checkTermsAndConditions() -> Bool {
    if isTermsAndConditionsChecked {
      resetError()
      return true
    } else {
      error = "Please acknowledge terms & conditions."
      return false
    }
  }
  
  private func resetError() {
    error = nil
  }
}
