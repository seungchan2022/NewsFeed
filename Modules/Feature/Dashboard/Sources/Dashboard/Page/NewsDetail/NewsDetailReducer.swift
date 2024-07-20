import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct NewsDetailReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: NewsDetailSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    let url = ""

    let item: NewsEntity.TopHeadlines.Item
    var fetchItem: FetchState.Data<NewsEntity.TopHeadlines.Item?> = .init(isLoading: false, value: .none)

    init(
      id: UUID = UUID(),
      item: NewsEntity.TopHeadlines.Item)
    {
      self.id = id
      self.item = item
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem
    case fetchItem(Result<NewsEntity.TopHeadlines.Item, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItem
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { _, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getItem:
//        state.url
        return .none

      case .fetchItem(let result):
        return .none

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: NewsDetailSideEffect

}
