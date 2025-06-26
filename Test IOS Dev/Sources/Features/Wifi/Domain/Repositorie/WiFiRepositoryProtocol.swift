//
//  WiFiRepositoryProtocol.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 25/06/25.
//

protocol WiFiRepositoryProtocol {
  func getCurrentNetwork() async -> WiFiInfo?
  func scanForNetworks() async throws -> [WiFiInfo]
  func stopScanning()
  func getLocationPermissionStatus() -> LocationPermissionStatus
  func requestLocationPermission() async -> LocationPermissionStatus
}
