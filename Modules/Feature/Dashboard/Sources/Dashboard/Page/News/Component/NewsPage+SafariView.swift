import SafariServices
import SwiftUI

// MARK: - NewsPage.SafariView

extension NewsPage {
  struct SafariView {
    let viewState: ViewState
  }
}

// MARK: - NewsPage.SafariView + UIViewControllerRepresentable

extension NewsPage.SafariView: UIViewControllerRepresentable {
  func makeUIViewController(context _: Context) -> SFSafariViewController {
    SFSafariViewController(url: viewState.url)
  }

  func updateUIViewController(_: SFSafariViewController, context _: Context) { }
}

// MARK: - NewsPage.SafariView.ViewState

extension NewsPage.SafariView {
  struct ViewState: Equatable {
    let url: URL
  }
}
