//
//  BluetoothRepositoryProtocol.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import Foundation
import Combine

protocol BluetoothRepositoryProtocol {
    var devices: AnyPublisher<[BluetoothDevice], Never> { get }
    var bluetoothState: AnyPublisher<String, Never> { get }
    
    func startScan()
    func stopScan()
} 