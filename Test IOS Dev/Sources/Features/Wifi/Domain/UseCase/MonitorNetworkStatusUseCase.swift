//
//  MonitorNetworkStatusUseCase.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

final class MonitorNetworkStatusUseCase {
  private let repository: NetworkStatusRepositoryProtocol
  
  init(repository: NetworkStatusRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() -> NetworkStatus {
    repository.getCurrentNetworkStatus()
  }
  
  func observeStatus() -> AsyncStream<NetworkStatus> {
    repository.observeNetworkStatus()
  }
}
