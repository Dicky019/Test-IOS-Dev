import ProjectDescription

enum TergetApp {
  case bluetooth
  case wifi
  
  var name: String {
    switch self {
    case .bluetooth:
      return "Search Bluetooth"
    case .wifi:
      return "Search Wifi"
    }
  }
  
  var bundleId: String {
    switch self {
    case .bluetooth:
      return "bluetooth"
    case .wifi:
      return "wifi"
    }
  }
  
  var infoPlistPermissions: [String: Plist.Value] {
    switch self {
    case .bluetooth:
      return [
        "UILaunchScreen": [
          "UIColorName": "",
          "UIImageName": "",
        ],
        "NSBluetoothAlwaysUsageDescription": "This app uses Bluetooth to scan for and connect to nearby devices.",
        "NSBluetoothPeripheralUsageDescription": "This app uses Bluetooth to discover and interact with nearby devices.",
        "NSLocationWhenInUseUsageDescription": "This app uses location services to improve Bluetooth device discovery."
      ]
    case .wifi:
      return [
        "UILaunchScreen": [
          "UIColorName": "",
          "UIImageName": "",
        ],
        "NSLocationWhenInUseUsageDescription": "This app requires location access to scan for WiFi networks.",
        "NSLocationAlwaysAndWhenInUseUsageDescription": "This app uses location services to discover WiFi networks and provide location-based features.",
        "NSLocalNetworkUsageDescription": "This app uses the local network to discover and connect to WiFi devices."
      ]
    }
  }
}

func myAppTerget(target: TergetApp) -> Target {
  .target(
    name: target.name,
    destinations: .iOS,
    product: .app,
    productName: target.name,
    bundleId: "diki.test.\(target.bundleId)",
    infoPlist: .extendingDefault(
      with: target.infoPlistPermissions
    ),
    sources: ["Test IOS Dev/Sources/**"],
    resources: ["Test IOS Dev/Resources/**"],
    dependencies: []
  )
}

let project = Project(
  name: "Test IOS Dev",
  targets: [
    myAppTerget(target: .wifi),
    myAppTerget(target: .bluetooth),
    .target(
      name: "Test IOS DevTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "io.tuist.Test-IOS-DevTests",
      infoPlist: .default,
      sources: ["Test IOS Dev/Tests/**"],
      resources: [],
      dependencies: [.target(name: TergetApp.bluetooth.name), .target(name: TergetApp.wifi.name)]
    ),
  ]
)