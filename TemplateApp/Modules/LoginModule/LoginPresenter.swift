//
//  LoginPresenter.swift
//  TemplateApp
//
//  Created by Abhishek Dhiman on 13/11/24.
//

import Foundation
import Combine

protocol LoginPresenterProtocol: ObservableObject {
  var email: String { get set }
  var password: String { get set }
  var errorMessage: String? { get set }
  func login()
}

class LoginPresenter: LoginPresenterProtocol {

  @Published
  var email: String = ""
  
  @Published
  var password: String = ""
  
  @Published
  var errorMessage: String? = nil

  
  private var cancellables: Set<AnyCancellable> = []
  
  private let interactor: LoginInteractorProtocol
  private let router: LoginRouterProtocol!
  private let loginValidation: LoginValidation
  
  init(interactor: LoginInteractorProtocol, router: LoginRouterProtocol, loginValidation: LoginValidation = .init()) {
    self.interactor = interactor
    self.router = router
    self.loginValidation = loginValidation
  }
  
  func login() {
    
    if let emailErrorMessage = validateEmail(with: email)  {
      errorMessage = emailErrorMessage
      return
    }
    
    if let passwordErrorMessage = validatePassword(with: password) {
      errorMessage = passwordErrorMessage
      return
    }

    //clear out error message
    errorMessage = nil
    
    let credential = LoginCredential(email: email, password: password)
    let userInfo = interactor.authenticateUser(with: credential)

    if let _ = userInfo  {
      router.navigateToHome()
    }
  }
  
  private func validateEmail(with email: String) -> String? {
    if !loginValidation.validateEmail(with: email) {
      let error =  "Please enter valid email address"
      return error
    }else {
      return nil
    }
  }
  
  private func validatePassword(with password: String) -> String? {
    if !loginValidation.isPasswordValid(password) {
      return "Password must be at-least 8 characters long and match up with standard set."
    } else {
      return nil
    }
  }
}
