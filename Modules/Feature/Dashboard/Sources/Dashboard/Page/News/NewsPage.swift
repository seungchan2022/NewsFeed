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

  private var isLoading: Bool {
    store.fetchItem.isLoading
  }

  private var navigationTitle: String {
    store.category == "general"
      ? "Top Headlines"
      : store.category.capitalized
  }
}

// MARK: View

extension NewsPage: View {
  var body: some View {
    VStack {
      DesignSystemNavigation(
        barItem: .init(title: ""),
        largeTitle: navigationTitle)
      {
        CategoryComponent(
          viewState: .init(),
          store: store)

        LazyVStack(spacing: 32) {
          ForEach(store.itemList, id: \.url) { item in
            ItemComponent(
              viewState: .init(item: item),
              tapAction: {
                store.isShowSafariView = true
                store.send(.selectedURL($0.url))
              })
              .onAppear {
                guard let last = store.itemList.last, last.url == item.url else { return }
                guard !store.fetchItem.isLoading else { return }
                store.send(.getItem(store.category))
              }
          }
        }
      }
    }
    .toolbar(.hidden, for: .navigationBar)
    .onChange(of: store.category) { _, new in
      store.itemList = []
      store.send(.getItem(new))
    }
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem(store.category))
    }
    .onDisappear {
      store.send(.teardown)
    }
    .fullScreenCover(isPresented: $store.isShowSafariView) {
      if let url = URL(string: store.selectedURL) {
        SafariView(viewState: .init(url: url))
          .ignoresSafeArea()
      }
    }
  }
}
