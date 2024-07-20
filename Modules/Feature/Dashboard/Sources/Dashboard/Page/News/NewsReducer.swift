import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - NewsReducer

@Reducer
struct NewsReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: NewsSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    var category = ""
    var selectedURL = ""
    var isShowSafariView = false

    var itemList: [NewsEntity.TopHeadlines.Item] = []
    var fetchItem: FetchState.Data<NewsEntity.TopHeadlines.Response?> = .init(isLoading: false, value: .none)

    init(id: UUID = UUID()) {
      self.id = id
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem(String)
    case fetchItem(Result<NewsEntity.TopHeadlines.Response, CompositeErrorRepository>)

    case selectedURL(String)

    case routeToTabBarItem(String)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItem
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getItem(let category):
        state.fetchItem.isLoading = true
        let page = Int(state.itemList.count / 20) + 1

        return sideEffect
          .getItem(.init(category: category, page: page))
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)

      case .fetchItem(let result):
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          state.itemList = state.itemList.merge(item.itemList)
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .selectedURL(let url):
        state.selectedURL = url
        return .none

      case .routeToTabBarItem(let matchPath):
        sideEffect.routeToTabBarItem(matchPath)
        return .none

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: NewsSideEffect

}

extension [NewsEntity.TopHeadlines.Item] {
  /// 중복된게 올라옴
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.url == next.url }) else { return curr }
      return curr + [next]
    }

    return new
  }
}
