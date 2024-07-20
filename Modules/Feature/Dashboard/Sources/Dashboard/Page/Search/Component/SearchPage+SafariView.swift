import SafariServices
import SwiftUI

// MARK: - SearchPage.SafariView

extension SearchPage {
  struct SafariView {
    let viewState: ViewState
  }
}

// MARK: - SearchPage.SafariView + UIViewControllerRepresentable

extension SearchPage.SafariView: UIViewControllerRepresentable {
  func makeUIViewController(context _: Context) -> SFSafariViewController {
    SFSafariViewController(url: viewState.url)
  }

  func updateUIViewController(_: SFSafariViewController, context _: Context) { }
}

// MARK: - SearchPage.SafariView.ViewState

extension SearchPage.SafariView {
  struct ViewState: Equatable {
    let url: URL
  }
}
