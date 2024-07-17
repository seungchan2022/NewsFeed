import Architecture
import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - NewsPage

struct NewsPage {
  @Bindable var store: StoreOf<NewsReducer>
}

extension NewsPage {
  private var tabNavigationComponentViewState: TabNavigationComponent.ViewState {
    .init(activeMatchPath: Link.Dashboard.Path.news.rawValue)
  }
}

// MARK: View

extension NewsPage: View {
  var body: some View {
    VStack {
      DesignSystemNavigation(
        barItem: .init(title: ""),
        largeTitle: "Top Headlines")
      {
        Text("News")
      }

      TabNavigationComponent(
        viewState: tabNavigationComponentViewState,
        tapAction: { store.send(.routeToTabBarItem($0)) })
    }
    .ignoresSafeArea(.all, edges: .bottom)
    .toolbar(.hidden, for: .navigationBar)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
