import XCTest
import Nimble
@testable import TemplateApp

final class RegisterPresenterTest: XCTestCase {
  
  private var presenter: RegisterPresenter!
  private var interactor: RegisterInteractorProtocol!
  
  override func setUp() {
    interactor = MockRegisterInteractor()
    presenter = .init(interactor: interactor, router: .init())
  }
  
  func test_valid_email_address() throws {
    let presenter = try XCTUnwrap(presenter)
    presenter.email = "test@gmail.com"
    presenter.isTermsAndConditionsChecked = true
    
    presenter.completeRegistration()
    expect(presenter.error).to(beNil())
  }
  
  func test_inValid_email_address() throws {
    let presenter = try XCTUnwrap(presenter)
    presenter.email = "testMail"
    presenter.isTermsAndConditionsChecked = true

    presenter.completeRegistration()
    expect(presenter.error).toNot(beNil())
    expect(presenter.error).to(equal("Please enter a valid email address"))
  }
}

class MockRegisterInteractor: RegisterInteractorProtocol {
  func registerNewUser() {
    //
  }
  
}
