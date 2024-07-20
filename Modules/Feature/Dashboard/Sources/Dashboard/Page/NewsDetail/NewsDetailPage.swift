import Architecture
import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI
import WebKit

// MARK: - NewsDetailPage

struct NewsDetailPage {
  @Bindable var store: StoreOf<NewsDetailReducer>
}

extension NewsDetailPage { }

// MARK: View

extension NewsDetailPage: View {
  var body: some View {
    VStack {
      DesignSystemNavigation(
        barItem: .init(title: ""),
        largeTitle: "NewsDetail")
      {
//        if let item = store.fetchItem.value {
//          WebContent(viewState: .init(item: item))
//        }
        Text("dd")
      }
    }
    .ignoresSafeArea(.all, edges: .bottom)
    .toolbar(.hidden, for: .navigationBar)
    .onAppear {
//      store.getItem
    }
  }
}

// MARK: NewsDetailPage.WebContent

extension NewsDetailPage {
  struct WebContent {
    let viewState: ViewState
  }
}

// MARK: - NewsDetailPage.WebContent + UIViewRepresentable

extension NewsDetailPage.WebContent: UIViewRepresentable {
  func makeUIView(context _: Context) -> some UIView {
    let webView = WKWebView(frame: .zero, configuration: .init())

    if let url = URL(string: viewState.item.url) {
      webView.load(.init(url: url))
    }
    return webView
  }

  func updateUIView(_: UIViewType, context _: Context) { }
}

// MARK: - NewsDetailPage.WebContent.ViewState

extension NewsDetailPage.WebContent {
  struct ViewState: Equatable {
    let item: NewsEntity.TopHeadlines.Item
  }
}
