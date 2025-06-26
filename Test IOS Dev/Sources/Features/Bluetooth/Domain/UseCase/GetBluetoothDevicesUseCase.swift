//
//  GetBluetoothDevicesUseCase.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import Foundation
import Combine

class GetBluetoothDevicesUseCase {
    private let bluetoothRepository: BluetoothRepositoryProtocol

    init(bluetoothRepository: BluetoothRepositoryProtocol) {
        self.bluetoothRepository = bluetoothRepository
    }

    func execute() -> AnyPublisher<[BluetoothDevice], Never> {
        return bluetoothRepository.devices
    }
} 