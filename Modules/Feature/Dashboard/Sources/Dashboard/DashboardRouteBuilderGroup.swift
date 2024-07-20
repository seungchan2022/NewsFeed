import Architecture
import LinkNavigator

// MARK: - DashboardRouteBuilderGroup

public struct DashboardRouteBuilderGroup<RootNavigator: RootNavigatorType> {
  public init() { }
}

extension DashboardRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator>] {
    [
      NewsRouteBuilder.generate(),
      NewsDetailRouteBuilder.generate(),
      SearchRouteBuilder.generate(),
      SavedRouteBuilder.generate(),
    ]
  }
}
