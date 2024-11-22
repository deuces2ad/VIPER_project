import SwiftUI

struct LandingView: View {
  
  private var router: LandingRouter
  
  init(router: LandingRouter) {
    self.router = .init()
  }
  
  var body: some View {
    OrangeBackgroundView {
      VStack(spacing:40) {
        // Module 1
        WorkoutTodayBannerView()
        // Module 2
        Text("• Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n \n• Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
          .lineLimit(nil)
          .font(.system(size: 25, weight: .bold))
          .padding()
        
        // buttons
        HStack(alignment: .center, spacing: 15) {
        NavigationLink(destination: { router.navigateToLogin() }) {
            Text("Sign in")
              .customTextStyle()
          }

          NavigationLink(destination: { router.navigateToRegister() }) {
              Text("Register")
                .customTextStyle()
            }
        }
      }
    }.ignoresSafeArea()
  }
}

#Preview {
  LandingView(router: .init())
}

struct RectangularBar: View {
  
  private let alignment: Alignment
  
  init(alignment: Alignment) {
    self.alignment = alignment
  }
  var body: some View {
      VStack(alignment: .leading) {
        Rectangle()
          .fill(.white)
          .frame(width: UIScreen.main.bounds.width * 0.50, height: 10)
          .padding(.leading, 0)
        
      }.frame(maxWidth: .infinity, alignment: alignment)
  }
}

struct CustomButton: View {
  private let action: () -> AnyView
  private let title: String
  
  init(action: @escaping () -> AnyView, title: String) {
    self.action = action
    self.title = title
  }
  var body: some View {
    NavigationLink(destination: { action() }) {
      Text(title)
        .customTextStyle()
    }
  }
}

struct CustomTextModifier: ViewModifier {
  private let tintColor: Color
  private let textColor: Color

  init(tintColor: Color, textColor: Color) {
    self.tintColor = tintColor
    self.textColor = textColor
  }
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.size.width * 0.40)
            .tint(textColor)
            .font(.system(size: 30))
            .padding(5)
            .background(tintColor)
            .cornerRadius(5)
    }
}

extension View {
  func customTextStyle(tintColor: Color = .white, textColor: Color = .black) -> some View {
    self.modifier(CustomTextModifier(tintColor: tintColor, textColor: textColor))
    }
}

struct WorkoutTodayBannerView: View {

  var body: some View {
    VStack(spacing: 5) {
      RectangularBar(alignment: .leading)
      
      HStack {
        Image("dumbble")
          .resizable()
          .tint(.white)
          .frame(width: 100, height: 100)
        
        Text("Workout \n today")
          .font(.system(size: 50, weight: .bold))
          .lineLimit(2)
          .fontWeight(.bold)
      }
      RectangularBar(alignment: .trailing)
    }
  }
}
