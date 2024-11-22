import Foundation
import SwiftUI

struct LoginView: View {
  
  @ObservedObject
  var loginPresenter: LoginPresenter
  
  @ObservedObject
  var loginRouter: LoginRouter
  
  @Environment(\.dismiss)
  var dismiss
  
  public init(loginPresenter: LoginPresenter, loginRouter: LoginRouter) {
    self.loginPresenter = loginPresenter
    self.loginRouter = loginRouter
  }
  
  private var isErrorPresented: Binding<Bool> {
    Binding(get: { loginPresenter.errorMessage != nil },
            set: { if !$0 { loginPresenter.errorMessage = nil }})
  }
  
  var body: some View {
    OrangeBackgroundView {
      VStack(spacing: 20) {
        WorkoutTodayBannerView()
          .padding([.bottom, .top], 20)
 
        Group {
          VStack(spacing: 20) {
            CustomTextfield(text: $loginPresenter.email,
                            title: "Email")
      
            CustomTextfield(text: $loginPresenter.password,
                            title: "Password",
                            isSecureTextField: true)
          }
        }.padding([.leading, .trailing])
        
        
        Button(action: { loginPresenter.login() }) {
          Text("Login")
            .customTextStyle()
        }
        Spacer()
      }
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button(action: { dismiss() }) {
            Image(systemName: "arrow.left")
              .foregroundColor(.white)
              .font(.system(size: 24))
          }
        }
      }
      .navigationDestination(isPresented: $loginRouter.isLoggedIn, destination: { DashboardView(selectedTab:  .calendar, presenter: .init(graphPresenter: .init()))})
      .errorAlert(errorMessage: loginPresenter.errorMessage ?? "", isErrorPresented: isErrorPresented)
    }
  }
}

#Preview {
  let interactor = LoginInteractor()
  let router = LoginRouter()
  let presenter = LoginPresenter(interactor: interactor, router: router)
  LoginView(loginPresenter: presenter, loginRouter: router)
}

struct ErrorAlert: ViewModifier {
  
  private let isPresented: Binding<Bool>
  private let errorMessage: String
  
  init(isPresented: Binding<Bool>, errorMessage: String) {
    self.isPresented = isPresented
    self.errorMessage = errorMessage
  }

  func body(content: Content) -> some View {
    content.alert(isPresented: isPresented) {
      Alert(title: Text("Error"),
            message: Text(errorMessage),
            dismissButton: .default(Text("Ok")))
    }
  }
}

extension View {
  func errorAlert(errorMessage: String, isErrorPresented: Binding<Bool>) -> some View {
    self.modifier(ErrorAlert(isPresented: isErrorPresented,
                             errorMessage: errorMessage))
  }
}

struct OrangeBackgroundView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
          Color.appOrange.ignoresSafeArea()
            content
        }
    }
}


struct CustomTextfield: View {
  
  private let text: Binding<String>
  private let title: String
  private let isSecureTextField: Bool
  
  init(text: Binding<String>, title: String, isSecureTextField: Bool = false) {
    self.text = text
    self.title = title
    self.isSecureTextField = isSecureTextField
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(title)
        .font(.system(size: 18))
        .fontWeight(.semibold)
      
      Group {
        if isSecureTextField {
          SecureField("", text: text)
        } else {
          TextField("", text: text)
        }
      } .frame(height: 50)
        .padding(.horizontal, 8)
        .background(Color.white)
        .border(Color.black, width: 4)
        .cornerRadius(10)
    }
  }
}
