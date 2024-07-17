import Architecture
import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - SearchPage

struct SearchPage {
  @Bindable var store: StoreOf<SearchReducer>
}

extension SearchPage {
  private var tabNavigationComponentViewState: TabNavigationComponent.ViewState {
    .init(activeMatchPath: Link.Dashboard.Path.search.rawValue)
  }

}

// MARK: View

extension SearchPage: View {
  var body: some View {
    VStack {
      DesignSystemNavigation(
        barItem: .init(title: ""),
        largeTitle: "Search")
      {
        Text("Search")
      }

      TabNavigationComponent(
        viewState: tabNavigationComponentViewState,
        tapAction: { store.send(.routeToTabBarItem($0)) })
    }
    .ignoresSafeArea(.all, edges: .bottom)
    .toolbar(.hidden, for: .navigationBar)
  }
}
