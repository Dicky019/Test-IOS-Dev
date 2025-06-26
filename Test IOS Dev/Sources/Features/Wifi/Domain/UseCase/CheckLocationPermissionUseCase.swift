//
//  CheckLocationPermissionUseCase.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

final class CheckLocationPermissionUseCase {
  private let repository: WiFiRepositoryProtocol
  
  init(repository: WiFiRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() -> LocationPermissionStatus {
    repository.getLocationPermissionStatus()
  }
  
  func requestPermission() async -> LocationPermissionStatus {
    await repository.requestLocationPermission()
  }
}
