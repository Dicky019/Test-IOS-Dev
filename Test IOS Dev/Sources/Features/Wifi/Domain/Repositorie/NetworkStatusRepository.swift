//
//  NetworkStatusRepositoryProtocol.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

protocol NetworkStatusRepositoryProtocol {
  func getCurrentNetworkStatus() -> NetworkStatus
  func observeNetworkStatus() -> AsyncStream<NetworkStatus>
}
