import Foundation
import XCTest
import Nimble
@testable import TemplateApp

final class RegisterInractor: XCTestCase {
  private var interactor: RegisterInteractorProtocol!
 
  override func setUp() {
    interactor = RegisterInteractor()
  }
  
  func test_register_new_user_with_success() throws {
    let interactor = try XCTUnwrap(interactor)
    interactor.registerNewUser()
  }
}
