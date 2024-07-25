import DesignSystem
import Domain
import SwiftUI

// MARK: - NewsPage.ItemComponent

extension NewsPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: (NewsEntity.TopHeadlines.Item) -> Void
  }
}

extension NewsPage.ItemComponent {
  private var publishedDate: String {
    let timeFormatter = RelativeDateTimeFormatter()
    return timeFormatter.localizedString(for: viewState.item.publishedAt.toDate ?? .now, relativeTo: Date())
  }
}

// MARK: - NewsPage.ItemComponent + View

extension NewsPage.ItemComponent: View {
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
    .onTapGesture {
      tapAction(viewState.item)
    }
  }
}

// MARK: - NewsPage.ItemComponent.ViewState

extension NewsPage.ItemComponent {
  struct ViewState: Equatable {
    let item: NewsEntity.TopHeadlines.Item
  }
}

extension String {
  fileprivate var toDate: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.date(from: self)
  }
}
