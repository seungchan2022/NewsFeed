import Architecture
import ComposableArchitecture
import Foundation

// MARK: - SavedSideEffect

struct SavedSideEffect {
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

extension SavedSideEffect {
  var routeToTabBarItem: (String) -> Void {
    { path in
      guard path != Link.Dashboard.Path.saved.rawValue else { return }
      navigator.replace(linkItem: .init(path: path), isAnimated: false)
    }
  }

}
