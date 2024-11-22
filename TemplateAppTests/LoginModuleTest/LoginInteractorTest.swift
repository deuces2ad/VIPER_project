import Foundation
import Nimble
@testable import TemplateApp
import XCTest

final class LoginInteractorTest: XCTestCase {
  
  func testAuthenticateUser_WithValidCredentials_ShouldReturnUserInfo() {
    let loginInteractor = LoginInteractor()
    let validCredentials = LoginCredential(email: "test@example.com", password: "password123")
    let result = loginInteractor.authenticateUser(with: validCredentials)
    expect(result).toNot(beNil(), description: "The result should not be nil for valid credentials.")
  }
}
