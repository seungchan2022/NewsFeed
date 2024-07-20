import Architecture
import Domain

public protocol DashboardEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var newsUseCase: NewsUseCase { get }
  var searchUseCase: SearchUseCase { get }
}
