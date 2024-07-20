import Architecture
import Domain
import LinkNavigator

struct NewsDetailRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.newsDetail.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: NewsEntity.TopHeadlines.Item = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        NewsDetailPage(store: .init(
          initialState: NewsDetailReducer.State(item: item),
          reducer: {
            NewsDetailReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
