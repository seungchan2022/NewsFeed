import Architecture
import ComposableArchitecture
import Foundation

// MARK: - NewsSideEffect

struct NewsSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType

  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension NewsSideEffect {

  var routeToTabBarItem: (String) -> Void {
    { path in
      guard path != Link.Dashboard.Path.news.rawValue else { return }
      navigator.replace(linkItem: .init(path: path), isAnimated: false)
    }
  }
}