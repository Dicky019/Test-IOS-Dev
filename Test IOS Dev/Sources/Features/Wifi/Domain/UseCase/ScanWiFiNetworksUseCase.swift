//
//  ScanWiFiNetworksUseCase.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

final class ScanWiFiNetworksUseCase {
  private let repository: WiFiRepositoryProtocol
  
  init(repository: WiFiRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() async throws -> [WiFiInfo] {
    try await repository.scanForNetworks()
  }
  
  func stopScanning() {
    repository.stopScanning()
  }
}
