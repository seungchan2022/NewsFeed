import DesignSystem
import Domain
import SwiftUI

// MARK: - SearchPage.ItemComponent

extension SearchPage {
  struct ItemComponent {
    let viewState: ViewState
  }
}

extension SearchPage.ItemComponent {
  private var publishedDate: String {
    let timeFormatter = RelativeDateTimeFormatter()
    return timeFormatter.localizedString(for: viewState.item.publishedAt.toDate ?? .now, relativeTo: Date())
  }
}

// MARK: - SearchPage.ItemComponent + View

extension SearchPage.ItemComponent: View {
  var body: some View {
    VStack(alignment: .leading) {
      RemoteImage(
        url: viewState.item.urlToImage ?? "",
        placeholder: {
          HStack {
            Spacer()
            Image(systemName: "photo")
              .imageScale(.large)
            Spacer()
          }
        })
        .frame(minHeight: 200, maxHeight: 300)
        .background(.gray.opacity(0.2))

      VStack(alignment: .leading, spacing: 8) {
        Text(viewState.item.title ?? "")
          .font(.headline)
          .lineLimit(3)

        Text(viewState.item.description ?? "")
          .font(.subheadline)
          .lineLimit(2)

        HStack {
          Text("\(viewState.item.source.name ?? "") - \(publishedDate)")
            .font(.caption)

          Spacer()

          Button(action: { }) {
            Image(systemName: "bookmark")
          }
          .buttonStyle(.bordered)

          ShareLink(item: viewState.item.url) {
            Image(systemName: "square.and.arrow.up")
          }
          .buttonStyle(.bordered)
        }
      }
      .padding(.vertical, 8)
      .padding(.horizontal, 8)
    }
    .frame(maxWidth: .infinity)
  }
}

// MARK: - SearchPage.ItemComponent.ViewState

extension SearchPage.ItemComponent {
  struct ViewState: Equatable {
    let item: NewsEntity.Search.Item
  }
}

extension String {
  fileprivate var toDate: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.date(from: self)
  }
}
