import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SearchReducer

@Reducer
struct SearchReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: SearchSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    var query = ""
    var perPage = 20
    var selectedURL = ""
    var isShowSafariView = false
    var fromDate = Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? Date()

    var itemList: [NewsEntity.Search.Item] = []
    var fetchSearchItem: FetchState.Data<NewsEntity.Search.Composite?> = .init(isLoading: false, value: .none)

    init(id: UUID = UUID()) {
      self.id = id
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case search(String)
    case fetchSearchItem(Result<NewsEntity.Search.Composite, CompositeErrorRepository>)

    case selectedURL(String)

    case routeToTabBarItem(String)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestSearch
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding(\.query):
        guard !state.query.isEmpty else {
          state.itemList = []
          return .cancel(pageID: pageID, id: CancelID.requestSearch)
        }

        if state.query != state.fetchSearchItem.value?.request.query {
          state.itemList = []
        }

        return .none

      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .search(let query):
        guard !query.isEmpty else {
          return .none
        }

        state.fetchSearchItem.isLoading = true
        let page = Int(state.itemList.count / state.perPage) + 1
        return sideEffect
          .search(.init(query: query, from: state.fromDate.toString, page: page, perPage: state.perPage))
          .cancellable(pageID: pageID, id: CancelID.requestSearch, cancelInFlight: true)

      case .fetchSearchItem(let result):
        state.fetchSearchItem.isLoading = false
        switch result {
        case .success(let item):
          if state.query == item.request.query {
            state.fetchSearchItem.value = item
            state.itemList = state.itemList.merge(item.response.itemList)
        }

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
  private let sideEffect: SearchSideEffect

}

extension [NewsEntity.Search.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.url == next.url }) else { return curr }
      return curr + [next]
    }

    return new
  }
}

extension Date {
  fileprivate var toString: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: self)
  }
}
