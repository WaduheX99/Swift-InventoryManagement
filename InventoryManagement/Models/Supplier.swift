//
//  Supplier.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 21/12/24.
//

import Foundation
import SwiftData

@Model
class Supplier: ObservableObject {
    var id: UUID = UUID()
    var nama: String
    var alamat: String
    var noTelp: String

    init(nama: String, alamat: String, noTelp: String) {
        self.nama = nama
        self.alamat = alamat
        self.noTelp = noTelp
    }
}
