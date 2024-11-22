import Foundation
import SwiftUI

struct DashboardView: View {
  @State
  private var selectedTab: DashboardTab = .health
  
  @State
  private var showSideMenu: Bool = false
  
  @ObservedObject
  var presenter: DashboardPresenter

    init(selectedTab: DashboardTab, presenter: DashboardPresenter) {
        self.selectedTab = selectedTab
        self.presenter = presenter
    }
  
  var body: some View {
      GeometryReader { geometry in
          ZStack {
              // Side Menu
              SideMenuView(selectedTab: $selectedTab, showSideMenu: $showSideMenu)
                  .frame(width: geometry.size.width * 0.75)
                  .offset(x: showSideMenu ? 0 : -geometry.size.width * 0.75)
                  .animation(.easeInOut(duration: 0.3), value: showSideMenu)

              // Main Content
            VStack(spacing: 0) {
                  // Navigation Bar with Hamburger Icon
                  TopNavBar(showSideMenu: $showSideMenu, selectedTab: $selectedTab)
                .frame(height: geometry.size.height * 0.08)
                .shadow(radius: 8)
                  
//                  ScrollView {
                      VStack(spacing: 0) {
                          switch selectedTab {
                          case .health:
                              HealthView(presenter: presenter.graphPresenter)
                          case .exercise:
                              ExerciseView(presenter: .init(interactor: ExerciseIntractor()))
                          case .profile:
                              Text("Profile Content")
                          case .calendar:
                              Text("Calendar Content")
                          case .settings:
                              Text("Settings Content")
                          }
                      }
                      .frame(maxWidth: .infinity)
                      .frame(height: geometry.size.height - geometry.size.height * 0.16)

                  // Bottom Navigation Bar
                  BottomNavigationBarView(selectedTab: $selectedTab)
                .frame(height: geometry.size.height * 0.08)

              }
              .offset(x: showSideMenu ? geometry.size.width * 0.75 : 0)
              .animation(.easeInOut(duration: 0.3), value: showSideMenu)
              

              // Overlay to Close Menu
              if showSideMenu {
                  Color.black.opacity(0.3)
                      .ignoresSafeArea()
                      .onTapGesture {
                          showSideMenu = false
                      }
              }
          }
          .navigationBarBackButtonHidden()
          .injectDashboardDependencies(using: presenter)
      }.edgesIgnoringSafeArea([.bottom])
  }

}

struct BottomBarButton: View {
    let iconName: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: iconName)
                .font(.system(size: 40))
                .foregroundColor(isSelected ? .white : .gray)
        }
        .padding(.vertical, 5)
        .onTapGesture(perform: action)
    }
}

#Preview {
  DashboardView(selectedTab: .health, presenter: .init(graphPresenter: .init()))
}

enum DashboardTab: CaseIterable {
    case health, exercise, profile, calendar, settings

    var title: String {
        switch self {
        case .health: return "Health"
        case .exercise: return "Exercise"
        case .profile: return "Profile"
        case .calendar: return "Calendar"
        case .settings: return "Settings"
        }
    }

    var icon: String {
        switch self {
        case .health: return "heart"
        case .exercise: return "figure.walk"
        case .profile: return "person.crop.circle"
        case .calendar: return "calendar"
        case .settings: return "gear"
        }
    }
}

struct BottomNavigationBarView: View {
    @Binding var selectedTab: DashboardTab

    var body: some View {
        HStack {
            ForEach(DashboardTab.allCases, id: \.self) { tab in
                BottomBarButton(iconName: tab.icon,
                                isSelected: selectedTab == tab,
                                action: { selectedTab = tab })
                if tab != DashboardTab.allCases.last {
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .background(.appOrange)
        .background(Color.white.shadow(radius: 2))
        
    }
}

struct SideMenuView: View {
    @Binding var selectedTab: DashboardTab
    @Binding var showSideMenu: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Menu")
                .font(.largeTitle)
                .bold()
                .padding(.top, 50)

            ForEach(DashboardTab.allCases, id: \.self) { tab in
                Button(action: {
                    selectedTab = tab
                    showSideMenu = false // Close the menu
                }) {
                    HStack {
                        Image(systemName: tab.icon)
                        .foregroundColor(Color.appPurple)
                        Text(tab.title)
                            .foregroundColor(.black)
                    }
                }
                .padding(.vertical, 10)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct NotificationBellIconView: View {
  
  private var count: Binding<Int>
  
  init(count: Binding<Int>) {
    self.count = count
  }
  
  var body: some View {
    ZStack(alignment: .topTrailing) {
      
      Image(systemName: "bell")
        .resizable()
        .frame(width: 30, height: 30)
        .foregroundColor(.black)
  
      ZStack {
        Circle()
          .fill(Color.red)
          .frame(width: 23, height: 18)
        Text(String(count.wrappedValue))
          .foregroundColor(.white)
          .font(.caption)
          .fontWeight(.bold)
      }
      .offset(x: 10, y: -10) // Position badge relative to the bell
    }
  }
}

struct TopNavBar: View {
  
  @Binding
   var showSideMenu: Bool
  
  @Binding
   var selectedTab: DashboardTab
  
  var body: some View {
    HStack {
      Button(action: { showSideMenu.toggle() }) {
        Image(systemName: "line.horizontal.3")
          .font(.title)
          .tint(Color.appPurple)
          .padding()
      }
      Spacer()
      
      VStack {
        HStack(spacing: 20) {
          Text(selectedTab.title)
            .font(.title2)
          ZStack {
            Circle()
              .fill(.appPurple)
              .frame(width: 40)
            Image(systemName: "person")
              .font(.title)
              .fontWeight(.bold)
          }
          
          NotificationBellIconView(count: .constant(2))
        }
      }
      .padding(.trailing, 20)
    }
  }
}


