//
//  BluetoothRepository.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import Foundation
import Combine

class BluetoothRepository: BluetoothRepositoryProtocol {
    private let bluetoothDataSource: BluetoothDataSourceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private let devicesSubject = CurrentValueSubject<[BluetoothDevice], Never>([])
    var devices: AnyPublisher<[BluetoothDevice], Never> {
        devicesSubject.eraseToAnyPublisher()
    }
    
    var bluetoothState: AnyPublisher<String, Never> {
        bluetoothDataSource.bluetoothStatePublisher
    }
    
    init(bluetoothDataSource: BluetoothDataSourceProtocol) {
        self.bluetoothDataSource = bluetoothDataSource
        subscribeToDataSource()
    }
    
    private func subscribeToDataSource() {
        bluetoothDataSource.discoveredDevicesPublisher
            .sink { [weak self] newDevice in
                guard let self = self else { return }
                var currentDevices = self.devicesSubject.value
                if let index = currentDevices.firstIndex(where: { $0.id == newDevice.id }) {
                    currentDevices[index] = newDevice
                } else {
                    currentDevices.append(newDevice)
                }
                
                let sortedDevices = currentDevices.sorted { device1, device2 in
                    let name1 = device1.name
                    let name2 = device2.name
                    
                    if name1 != name2 {
                        return name1 < name2
                    }
                    
                    return device1.discoveredAt < device2.discoveredAt
                }
                
                self.devicesSubject.send(sortedDevices)
            }
            .store(in: &cancellables)
    }
    
    func startScan() {
        devicesSubject.send([])
        bluetoothDataSource.startScanning()
    }
    
    func stopScan() {
        bluetoothDataSource.stopScanning()
    }
} 