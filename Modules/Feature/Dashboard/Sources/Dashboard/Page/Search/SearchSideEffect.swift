import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SearchSideEffect

struct SearchSideEffect {
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

extension SearchSideEffect {
  var search: (NewsEntity.Search.Request) -> Effect<SearchReducer.Action> {
    { req in
      .publisher {
        useCase.searchUseCase
          .search(req)
          .map {
            NewsEntity.Search.Composite(
              request: req,
              response: $0)
          }
          .receive(on: main)
          .mapToResult()
          .map(SearchReducer.Action.fetchSearchItem)
      }
    }
  }

  var routeToTabBarItem: (String) -> Void {
    { path in
      guard path != Link.Dashboard.Path.search.rawValue else { return }
      navigator.replace(linkItem: .init(path: path), isAnimated: false)
    }
  }

}
