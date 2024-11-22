import SwiftUI

@main
struct TemplateAppApp: App {
    var body: some Scene {
        WindowGroup {
          let router = LandingRouter()
          NavigationStack {
            LandingView(router: router)
          }
        }
    }
}
