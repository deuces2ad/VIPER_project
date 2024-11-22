import Foundation

struct LoginValidation {
  
  func validateEmail(with email: String) -> Bool {
    let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
  }
  
  func isPasswordValid(_ password: String) -> Bool {
      // Single regex pattern: at least one uppercase, one lowercase, one digit, one special character, and minimum 8 characters
      let pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*()_+=-]).{8,}$"
      let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
      return predicate.evaluate(with: password)
  }
}
