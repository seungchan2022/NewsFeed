import Architecture
import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - SavedPage

struct SavedPage {
  @Bindable var store: StoreOf<SavedReducer>
}

extension SavedPage {
  private var tabNavigationComponentViewState: TabNavigationComponent.ViewState {
    .init(activeMatchPath: Link.Dashboard.Path.saved.rawValue)
  }

}

// MARK: View

extension SavedPage: View {
  var body: some View {
    VStack {
      DesignSystemNavigation(
        barItem: .init(title: ""),
        largeTitle: "Saved")
      {
        Text("Saved")
      }

    }
    .toolbar(.hidden, for: .navigationBar)
  }
}
