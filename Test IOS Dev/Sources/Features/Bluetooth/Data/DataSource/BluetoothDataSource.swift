//
//  BluetoothDataSource.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import Foundation
import CoreBluetooth
import Combine

protocol BluetoothDataSourceProtocol {
  var discoveredDevicesPublisher: AnyPublisher<BluetoothDevice, Never> { get }
  var bluetoothStatePublisher: AnyPublisher<String, Never> { get }
  func startScanning()
  func stopScanning()
}

class BluetoothDataSource: NSObject, BluetoothDataSourceProtocol {
  private var centralManager: CBCentralManager!
  private let discoveredDevicesSubject = PassthroughSubject<BluetoothDevice, Never>()
  private let bluetoothStateSubject = PassthroughSubject<String, Never>()
  
  var discoveredDevicesPublisher: AnyPublisher<BluetoothDevice, Never> {
    discoveredDevicesSubject.eraseToAnyPublisher()
  }
  
  var bluetoothStatePublisher: AnyPublisher<String, Never> {
    bluetoothStateSubject.eraseToAnyPublisher()
  }
  
  override init() {
    super.init()
    centralManager = CBCentralManager(delegate: self, queue: nil)
  }
  
  func startScanning() {
    guard centralManager.state == .poweredOn else {
      print("Bluetooth is not powered on")
      return
    }
    centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
  }
  
  func stopScanning() {
    centralManager.stopScan()
  }
}


extension BluetoothDataSource: CBCentralManagerDelegate {
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    let state: String
    switch central.state {
    case .unknown:
      state = "Unknown"
    case .resetting:
      state = "Resetting"
    case .unsupported:
      state = "Unsupported"
    case .unauthorized:
      state = "Unauthorized"
    case .poweredOff:
      state = "Powered Off"
    case .poweredOn:
      state = "Powered On"
    @unknown default:
      state = "Unknown"
    }
    bluetoothStateSubject.send(state)
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    let uuid = peripheral.identifier
    
    let unknownDevice = "Unknown Device"
    
    let name = peripheral.name ?? advertisementData[CBAdvertisementDataLocalNameKey] as? String ?? unknownDevice
    
    if unknownDevice == name {
      return
    }
    
    let discoveredDevice = BluetoothDevice(
      name: name,
      identifier: uuid.uuidString,
      rssi: RSSI.intValue,
      deviceType: inferDeviceType(from: peripheral.name, advertisementData: advertisementData),
      isConnected: peripheral.state == .connected,
      services: extractServices(from: advertisementData)
    )
    
    discoveredDevicesSubject.send(discoveredDevice)
  }
  
  private func extractServices(from advertisementData: [String: Any]) -> [String] {
    guard let serviceUUIDs = advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] else {
      return []
    }
    
    return serviceUUIDs.map { $0.uuidString }
  }
  
  private func inferDeviceType(from name: String?, advertisementData: [String: Any]) -> BluetoothDevice.DeviceType {
    guard let name = name?.lowercased() else { return .unknown }
    
    if name.contains("airpods") || name.contains("beats") || name.contains("headphone") {
      return .headphones
    } else if name.contains("watch") {
      return .watch
    } else if name.contains("keyboard") {
      return .keyboard
    } else if name.contains("mouse") || name.contains("magic") {
      return .mouse
    } else if name.contains("speaker") {
      return .speaker
    } else if name.contains("iphone") || name.contains("ipad") {
      return .phone
    } else if name.contains("mac") || name.contains("book") {
      return .computer
    }
    
    return .unknown
  }
}
