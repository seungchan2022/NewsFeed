import Architecture
import LinkNavigator
import SwiftUI

// MARK: - AppMain

struct AppMain {
  let viewModel: AppViewModel
}

// MARK: View

extension AppMain: View {

  var body: some View {
    TabLinkNavigationView(
      linkNavigator: viewModel.linkNavigator,
      isHiddenDefaultTabbar: false,
      tabItemList: [
        .init(
          tag: .zero,
          tabItem: .init(title: "News", image: UIImage(systemName: "newspaper.fill"), tag: .zero),
          linkItem: .init(path: Link.Dashboard.Path.news.rawValue)),
        .init(
          tag: 1,
          tabItem: .init(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1),
          linkItem: .init(path: Link.Dashboard.Path.search.rawValue)),
//        .init(
//          tag: 2,
//          tabItem: .init(title: "Saved", image: UIImage(systemName: "bookmark.fill"), tag: 2),
//          linkItem: .init(path: Link.Dashboard.Path.saved.rawValue)),
      ])
      .ignoresSafeArea()
      .onAppear()
  }
}
