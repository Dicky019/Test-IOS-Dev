//
//  BSSIDGenerator.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import Foundation

/// Utility for generating MAC addresses / BSSIDs
enum BSSIDGenerator {
  
  /// Generates a random BSSID/MAC address in the format XX:XX:XX:XX:XX:XX
  /// - Returns: A string representing a valid MAC address
  static func generate() -> String {
    (0..<6)
      .map { _ in randomHexByte() }
      .joined(separator: ":")
  }
  
  /// Generates a random BSSID with a specific vendor prefix
  /// - Parameter vendorPrefix: The first 3 bytes of the MAC address (e.g., "00:1B:63" for Apple)
  /// - Returns: A MAC address with the specified vendor prefix
  static func generate(withVendorPrefix vendorPrefix: String) -> String {
    let suffixBytes = (0..<3)
      .map { _ in randomHexByte() }
      .joined(separator: ":")
    
    return "\(vendorPrefix):\(suffixBytes)"
  }
  
  /// Generates multiple unique random BSSIDs
  /// - Parameter count: Number of unique BSSIDs to generate
  /// - Returns: Array of unique BSSID strings
  static func generateMultiple(count: Int) -> [String] {
    var bssids = Set<String>()
    
    while bssids.count < count {
      bssids.insert(generate())
    }
    
    return Array(bssids)
  }
  
  /// Generates a random hexadecimal byte (00-FF)
  /// - Returns: A two-character hexadecimal string
  private static func randomHexByte() -> String {
    String(format: "%02X", Int.random(in: 0...255))
  }
}

// MARK: - Common Vendor Prefixes
extension BSSIDGenerator {
  enum VendorPrefix {
    static let apple = "00:1B:63"
    static let cisco = "00:1A:A1"
    static let netgear = "00:1F:33"
    static let tpLink = "00:1D:0F"
    static let dLink = "00:1B:11"
    static let asus = "00:1E:8C"
    static let linksys = "00:1C:10"
    static let huawei = "00:1E:10"
    static let samsung = "00:1D:25"
    static let intel = "00:1B:21"
  }
}

// MARK: - Extension for more realistic network simulation
extension BSSIDGenerator {
  
  /// Generates a BSSID that appears to be from the same network (similar prefix)
  /// - Parameter baseBSSID: The base BSSID to derive from
  /// - Returns: A new BSSID with the same first 4 bytes
  static func generateSimilar(to baseBSSID: String) -> String {
    let components = baseBSSID.split(separator: ":")
    guard components.count == 6 else {
      return generate()
    }
    
    // Keep first 4 bytes, randomize last 2
    let prefix = components[0..<4].joined(separator: ":")
    let suffix = (0..<2)
      .map { _ in randomHexByte() }
      .joined(separator: ":")
    
    return "\(prefix):\(suffix)"
  }
}
