//
//  StopScanningUseCase.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import Foundation

class StopScanningUseCase {
    private let bluetoothRepository: BluetoothRepositoryProtocol

    init(bluetoothRepository: BluetoothRepositoryProtocol) {
        self.bluetoothRepository = bluetoothRepository
    }

    func execute() {
        bluetoothRepository.stopScan()
    }
} 