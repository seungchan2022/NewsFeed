import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - NewsPage.CategoryComponent

extension NewsPage {
  struct CategoryComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<NewsReducer>
  }
}

extension NewsPage.CategoryComponent {
  private var categoryList: [String] {
    [
      "", "business", "entertainment", "health", "science", "sports", "technology",
    ]
  }

}

// MARK: - NewsPage.CategoryComponent + View

extension NewsPage.CategoryComponent: View {
  var body: some View {
    ScrollView(.horizontal) {
      HStack {
        ForEach(categoryList, id: \.self) { item in
          Button(action: {
            store.category = item
          }) {
            if item == "" {
              Text("Top Headlines")
            }

            Text(item.capitalized)
          }
          .buttonStyle(.bordered)
          .buttonBorderShape(.capsule)
          .controlSize(.small)
        }
      }
      .padding(.leading, 12)
    }
    .scrollIndicators(.hidden)
  }
}

// MARK: - NewsPage.CategoryComponent.ViewState

extension NewsPage.CategoryComponent {
  struct ViewState: Equatable { }
}
