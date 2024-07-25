import Architecture
import ComposableArchitecture
import DesignSystem
import Functor
import SwiftUI

// MARK: - SearchPage

struct SearchPage {
  @Bindable var store: StoreOf<SearchReducer>

  @State var throttleEvent: ThrottleEvent = .init(value: "", delaySeconds: 1.5)

}

extension SearchPage {
  private var tabNavigationComponentViewState: TabNavigationComponent.ViewState {
    .init(activeMatchPath: Link.Dashboard.Path.search.rawValue)
  }

  private var isLoading: Bool {
    store.fetchSearchItem.isLoading
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
        SearchBar(
          viewState: .init(text: $store.query),
          throttleAction: { })

        if store.itemList.isEmpty {
          VStack {
            Image(systemName: "magnifyingglass")
              .resizable()
              .fontWeight(.light)
              .frame(width: 150, height: 150)

            Text("Search for the information you want to find.")
              .font(.body)
          }
          .padding(.top, 120)
        }

        LazyVStack {
          ForEach(store.itemList, id: \.url) { item in
            ItemComponent(
              viewState: .init(item: item),
              tapAction: {
                store.isShowSafariView = true
                store.send(.selectedURL($0.url))
              })
              .onAppear {
                guard let last = store.itemList.last, last.url == item.url else { return }
                guard !store.fetchSearchItem.isLoading else { return }
                store.send(.search(store.query))
              }
          }
        }
      }
    }
    .scrollDismissesKeyboard(.immediately)
    .toolbar(.hidden, for: .navigationBar)
    .onChange(of: store.query) { _, new in
      throttleEvent.update(value: new)
    }
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      throttleEvent.apply { _ in
        store.send(.search(store.query))
      }
    }
    .onDisappear {
      throttleEvent.reset()
      store.send(.teardown)
    }
    .sheet(isPresented: $store.isShowSafariView) {
      if let url = URL(string: store.selectedURL) {
        SafariView(viewState: .init(url: url))
          .ignoresSafeArea()
      }
    }
  }
}
