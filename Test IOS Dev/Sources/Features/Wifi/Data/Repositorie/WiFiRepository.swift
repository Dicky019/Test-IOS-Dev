//
//  WiFiRepository 2.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

final class WiFiRepository: WiFiRepositoryProtocol {
  private let dataSource: WiFiDataSourceProtocol
  private let locationDataSource: LocationPermissionDataSourceProtocol
  
  init(
    dataSource: WiFiDataSourceProtocol,
    locationDataSource: LocationPermissionDataSourceProtocol
  ) {
    self.dataSource = dataSource
    self.locationDataSource = locationDataSource
  }
  
  func getCurrentNetwork() async -> WiFiInfo? {
    dataSource.getCurrentNetworkInfo()
  }
  
  func scanForNetworks() async throws -> [WiFiInfo] {
    guard getLocationPermissionStatus() == .authorized else {
      throw WiFiError.locationPermissionDenied
    }
    
    return try await dataSource.scanForNetworks()
  }
  
  func stopScanning() {
    dataSource.stopScanning()
  }
  
  func getLocationPermissionStatus() -> LocationPermissionStatus {
    locationDataSource.checkPermissionStatus()
  }
  
  func requestLocationPermission() async -> LocationPermissionStatus {
    await locationDataSource.requestPermission()
  }
}
