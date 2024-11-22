import Foundation
import SwiftUI

struct RegisterView: View {
  
  @ObservedObject
  var presenter: RegisterPresenter
  
  @ObservedObject
  var router: RegisterRouter
  
  init(presenter: RegisterPresenter, router: RegisterRouter) {
    self.presenter = presenter
    self.router = router
  }
  
  var body: some View {
    VStack {
      StepHeaderView()
      ScrollView {
        VStack(spacing: 25) {
          RegisterTextField(name: $presenter.name,
                            title: "Your Name")

          RegisterTextField(name: $presenter.email,
                            title: "Your Email")
          
          RegisterTextField(name: $presenter.password,
                            title: "Create Password",
                            isSecureField: true)
          
          HStack {
            SquareCheckmarkButton(isChecked: $presenter.isTermsAndConditionsChecked)
            Text("I agree with terms & conditions")
              .font(.title3)
              .fontWeight(.semibold)
            Spacer()
          }

          Button(action: { presenter.completeRegistration() }) {
            Text("COMPLETE")
              .customTextStyle(tintColor: .appPurple,
                               textColor: .white)
          }
        }
      }
      .padding(.top, 20)
      Spacer()
    }.navigationDestination(isPresented: $router.isRegistrationComplete,
                            destination: {
      router.navigateToDashboardView()
    })
    .errorAlert(errorMessage: presenter.error ?? "",
                 isErrorPresented: isErrorPresented)
    .padding([.leading, .trailing])
  }
  
  private var isErrorPresented: Binding<Bool> {
    Binding(get: { presenter.error != nil},
            set: { if !$0 { presenter.error = nil }})
  }
}


//#Preview {
//  RegisterView(presenter: .init(interactor: RegisterInteractor(), router: <#RegisterRouter#>), router: .init())
//}

struct SquareCheckmarkButton: View {
  
  private var isChecked: Binding<Bool>
  
  init(isChecked: Binding<Bool>) {
    self.isChecked = isChecked
  }

    var body: some View {
        Button(action: {
          isChecked.wrappedValue.toggle()
        }) {
            ZStack {
                // Square background
                RoundedRectangle(cornerRadius: 4)
                .stroke(isChecked.wrappedValue ? Color.green : Color.gray, lineWidth: 2)
                    .frame(width: 35, height: 35)
                    .background(isChecked.wrappedValue ? Color.orange : Color.clear)
                    .cornerRadius(4)
                
                // Checkmark
              if isChecked.wrappedValue {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold))
                }
            }
        }
        .buttonStyle(.plain)
    }
}

struct StepHeaderView: View {
  var body: some View {
    VStack {
      HStack {
        HStack(spacing: 5) {
          Text("Step")
            .font(.system(size: 30))
            .fontWeight(.bold)
          
          ZStack {
            Circle()
              .frame(width: 40)
              .foregroundColor(Color.appPurple)
            
            Text("1")
              .font(.system(size: 28))
              .fontWeight(.bold)
          }
        }
        Spacer()
        Text("Account")
          .font(.system(size: 28))
          .fontWeight(.bold)
      }
    }
  }
}

struct RegisterTextField: View {
  
  private let name: Binding<String>
  private let title: String
  private let isSecureField: Bool
  
  init(name: Binding<String>, title: String, isSecureField: Bool = false) {
    self.name = name
    self.title = title
    self.isSecureField = isSecureField
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 3) {
      Text(title)
        .font(.title2)
      
      Group {
        if isSecureField {
          SecureField(title, text: name)
        } else {
          TextField(title, text: name)
        }
      }
      .font(.title)
      .frame(height: 50)
      
      Capsule()
        .foregroundColor(.black.opacity(0.3))
        .frame(height: 2)
      
    }
  }
}
