import Combine

public protocol NewsUseCase {
  var general: (NewsEntity.TopHeadlines.General.Request) -> AnyPublisher<
    NewsEntity.TopHeadlines.General.Response,
    CompositeErrorRepository
  > { get }
}
