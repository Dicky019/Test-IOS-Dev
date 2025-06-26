//
//  GetWiFiInfoUseCase.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 25/06/25.
//

final class GetWiFiInfoUseCase {
  private let repository: WiFiRepositoryProtocol
  
  init(repository: WiFiRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() async -> WiFiInfo? {
    await repository.getCurrentNetwork()
  }
}
