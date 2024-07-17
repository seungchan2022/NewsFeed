import ComposableArchitecture
import SwiftUI

// MARK: - NewsPage

struct NewsPage {
  @Bindable var store: StoreOf<NewsReducer>
}

extension NewsPage { }

// MARK: View

extension NewsPage: View {
  var body: some View {
    Text("New Page")
  }
}
