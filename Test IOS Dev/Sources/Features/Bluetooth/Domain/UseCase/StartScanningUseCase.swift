//
//  StartScanningUseCase.swift
//  Test IOS Dev
//
//  Created by Dicky Darmawan on 26/06/25.
//

import Foundation

class StartScanningUseCase {
    private let bluetoothRepository: BluetoothRepositoryProtocol

    init(bluetoothRepository: BluetoothRepositoryProtocol) {
        self.bluetoothRepository = bluetoothRepository
    }

    func execute() {
        bluetoothRepository.startScan()
    }
} 