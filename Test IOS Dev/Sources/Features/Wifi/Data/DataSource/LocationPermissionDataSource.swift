//
//  LocationPermissionDataSource.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import CoreLocation

protocol LocationPermissionDataSourceProtocol {
  func checkPermissionStatus() -> LocationPermissionStatus
  func requestPermission() async -> LocationPermissionStatus
}

final class LocationPermissionDataSource: NSObject, LocationPermissionDataSourceProtocol, CLLocationManagerDelegate {
  private let locationManager = CLLocationManager()
  private var permissionContinuation: CheckedContinuation<LocationPermissionStatus, Never>?
  
  override init() {
    super.init()
    locationManager.delegate = self
  }
  
  func checkPermissionStatus() -> LocationPermissionStatus {
    mapAuthorizationStatus(locationManager.authorizationStatus)
  }
  
  func requestPermission() async -> LocationPermissionStatus {
    await withCheckedContinuation { continuation in
      self.permissionContinuation = continuation
      self.locationManager.requestWhenInUseAuthorization()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    let permissionStatus = mapAuthorizationStatus(status)
    permissionContinuation?.resume(returning: permissionStatus)
    permissionContinuation = nil
  }
  
  private func mapAuthorizationStatus(_ status: CLAuthorizationStatus) -> LocationPermissionStatus {
    switch status {
    case .notDetermined:
      return .notDetermined
    case .denied:
      return .denied
    case .restricted:
      return .restricted
    case .authorizedWhenInUse, .authorizedAlways:
      return .authorized
    @unknown default:
      return .unknown
    }
  }
}
