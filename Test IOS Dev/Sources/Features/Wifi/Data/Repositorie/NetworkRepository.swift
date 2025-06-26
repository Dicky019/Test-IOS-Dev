//
//  NetworkRepository.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

final class NetworkRepository: NetworkStatusRepositoryProtocol {
  private let dataSource: NetworkStatusDataSourceProtocol
  
  init(dataSource: NetworkStatusDataSourceProtocol) {
    self.dataSource = dataSource
  }
  
  func getCurrentNetworkStatus() -> NetworkStatus {
    dataSource.checkNetworkStatus()
  }
  
  func observeNetworkStatus() -> AsyncStream<NetworkStatus> {
    AsyncStream { continuation in
      // Send initial status
      continuation.yield(getCurrentNetworkStatus())
      
      // Monitor changes
      dataSource.startMonitoring { status in
        continuation.yield(status)
      }
      
      continuation.onTermination = { _ in
        self.dataSource.stopMonitoring()
      }
    }
  }
}
