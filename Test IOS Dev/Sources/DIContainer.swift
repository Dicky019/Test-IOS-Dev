//
//  DIContainer.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

// DIContainer.swift
final class DIContainer {
  static let shared = DIContainer()
  
  private init() {}
  
  // Data Sources
  private lazy var wifiDataSource: WiFiDataSourceProtocol = WiFiDataSource()
  private lazy var networkStatusDataSource: NetworkStatusDataSourceProtocol = NetworkStatusDataSource()
  private lazy var locationPermissionDataSource: LocationPermissionDataSourceProtocol = LocationPermissionDataSource()
  
  // Repositories
  private lazy var wifiRepository: WiFiRepositoryProtocol = WiFiRepository(
    dataSource: wifiDataSource,
    locationDataSource: locationPermissionDataSource
  )
  
  private lazy var networkRepository: NetworkStatusRepositoryProtocol = NetworkRepository(
    dataSource: networkStatusDataSource
  )
  
  // Use Cases
  lazy var getWiFiInfoUseCase: GetWiFiInfoUseCase = GetWiFiInfoUseCase(
    repository: wifiRepository
  )
  
  lazy var scanWiFiNetworksUseCase: ScanWiFiNetworksUseCase = ScanWiFiNetworksUseCase(
    repository: wifiRepository
  )
  
  lazy var monitorNetworkStatusUseCase: MonitorNetworkStatusUseCase = MonitorNetworkStatusUseCase(
    repository: networkRepository
  )
  
  lazy var checkLocationPermissionUseCase: CheckLocationPermissionUseCase = CheckLocationPermissionUseCase(
    repository: wifiRepository
  )
}
