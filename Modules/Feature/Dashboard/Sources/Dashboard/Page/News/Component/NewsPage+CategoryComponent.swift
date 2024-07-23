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

extension NewsPage.CategoryComponent { }

// MARK: - NewsPage.CategoryComponent + View

extension NewsPage.CategoryComponent: View {
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 16) {
        ForEach(CategoryList.allCases, id: \.self) { item in
          Text(item.rawValue == "general" ? "Top Healines" : item.rawValue.capitalized)
            .fontWeight(.semibold)
            .foregroundStyle(store.category == item.rawValue ? .black : .gray)
            .padding(8)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
              store.category = item.rawValue
            }
        }
      }
      .padding(.horizontal, 12)
    }
    .scrollIndicators(.hidden)
  }
}

// MARK: - NewsPage.CategoryComponent.ViewState

extension NewsPage.CategoryComponent {
  struct ViewState: Equatable { }
}
