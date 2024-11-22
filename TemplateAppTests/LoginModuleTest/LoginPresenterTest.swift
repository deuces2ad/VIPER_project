import Foundation
import Nimble
@testable import TemplateApp
import XCTest

final class LoginPresenterTest: XCTestCase {
  
  private var router: LoginRouterProtocol!
  private var interactor: LoginInteractorProtocol!
  private var presenter: LoginPresenter!
  
  override func setUp() {
    router = MockLoginRouter()
    interactor = MockLoginInteractor()
    presenter = LoginPresenter(interactor: interactor, router: router)
  }
  
  func test_Login_return_success() throws {
    let presenter = try XCTUnwrap(presenter)
    let interactor = try XCTUnwrap(interactor as? MockLoginInteractor)
    let router = try XCTUnwrap(router)
    
    presenter.email = "test@gmail.com"
    presenter.password = "Abhishek#95"
    interactor.shouldAuthenticate = true
    presenter.login()
    
    expect(router.isLoggedIn).to(beTrue())
  }
  
  func test_Login_with_invalid_email_should_set_error_message() throws {
      let presenter = try XCTUnwrap(presenter)
      
      presenter.email = "invalid_email"
      presenter.password = "ValidPassword123"
    
      presenter.login()
      
      expect(presenter.errorMessage).to(equal("Please enter valid email address"))
  }
  
  func test_Login_with_invalid_password_should_set_error_message() throws {
      let presenter = try XCTUnwrap(presenter)
      
      presenter.email = "test@gmail.com"
      presenter.password = "short"
      
      presenter.login()
      
      expect(presenter.errorMessage).to(equal("Password must be at-least 8 characters long and match up with standard set."))
  }
  
  func test_Login_authentication_failure_should_not_navigate() throws {
      let presenter = try XCTUnwrap(presenter)
      let interactor = try XCTUnwrap(interactor as? MockLoginInteractor)
      let router = try XCTUnwrap(router as? MockLoginRouter)
      
      presenter.email = "test@gmail.com"
      presenter.password = "Abhishek#95"
      interactor.shouldAuthenticate = false
      
      presenter.login()
      
      expect(router.isLoggedIn).to(beFalse())
      expect(presenter.errorMessage).to(beNil())
  }
  
  func test_Login_success_should_clear_error_message() throws {
      let presenter = try XCTUnwrap(presenter)
      let interactor = try XCTUnwrap(interactor as? MockLoginInteractor)
      let router = try XCTUnwrap(router)
      
      presenter.email = "test@gmail.com"
      presenter.password = "ValidPassword#123"
      presenter.errorMessage = "Previous error"
      interactor.shouldAuthenticate = true
      
      presenter.login()
      
      expect(router.isLoggedIn).to(beTrue())
      expect(presenter.errorMessage).to(beNil()) 
  }
}

class MockLoginInteractor: LoginInteractorProtocol {
  var shouldAuthenticate: Bool = false
  
  func authenticateUser(with loginCredential: TemplateApp.LoginCredential) -> TemplateApp.UserInfo? {
    if shouldAuthenticate {
      return UserInfo(firstName: "TestName", lastName: "l")
    } else {
      return nil
    }
  }
  
}
class MockLoginRouter: LoginRouterProtocol {
  var isLoggedIn: Bool = false
  
  func navigateToHome() {
    isLoggedIn = true
  }
}
