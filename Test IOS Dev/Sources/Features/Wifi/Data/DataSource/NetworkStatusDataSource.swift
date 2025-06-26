//
//  NetworkStatusDataSource.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import SystemConfiguration

protocol NetworkStatusDataSourceProtocol {
  func checkNetworkStatus() -> NetworkStatus
  func startMonitoring(callback: @escaping (NetworkStatus) -> Void)
  func stopMonitoring()
}

final class NetworkStatusDataSource: NetworkStatusDataSourceProtocol {
  private var reachability: SCNetworkReachability?
  private var callback: ((NetworkStatus) -> Void)?
  
  func checkNetworkStatus() -> NetworkStatus {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
        SCNetworkReachabilityCreateWithAddress(nil, $0)
      }
    }) else {
      return .unknown
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
      return .unknown
    }
    
    let isReachable = flags.contains(.reachable)
    let isWiFi = !flags.contains(.isWWAN)
    
    if isReachable {
      return .connected(type: isWiFi ? .wifi : .cellular)
    } else {
      return .disconnected
    }
  }
  
  func startMonitoring(callback: @escaping (NetworkStatus) -> Void) {
    self.callback = callback
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    reachability = withUnsafePointer(to: &zeroAddress) {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
        SCNetworkReachabilityCreateWithAddress(nil, $0)
      }
    }
    
    guard let reachability = reachability else { return }
    
    var context = SCNetworkReachabilityContext(
      version: 0,
      info: Unmanaged.passUnretained(self).toOpaque(),
      retain: nil,
      release: nil,
      copyDescription: nil
    )
    
    let callbackClosure: SCNetworkReachabilityCallBack = { _, flags, info in
      guard let info = info else { return }
      let dataSource = Unmanaged<NetworkStatusDataSource>.fromOpaque(info).takeUnretainedValue()
      dataSource.notifyStatusChanged()
    }
    
    SCNetworkReachabilitySetCallback(reachability, callbackClosure, &context)
    SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
  }
  
  func stopMonitoring() {
    guard let reachability = reachability else { return }
    SCNetworkReachabilityUnscheduleFromRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
    self.reachability = nil
  }
  
  private func notifyStatusChanged() {
    let status = checkNetworkStatus()
    callback?(status)
  }
}
