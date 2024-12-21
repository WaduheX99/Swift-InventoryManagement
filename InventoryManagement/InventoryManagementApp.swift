//
//  InventoryManagementApp.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 11/12/24.
//

import SwiftUI
import SwiftData

@main
struct InventoryManagementApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .modelContainer(for: [Barang.self, RiwayatTransaksi.self, Supplier.self])
        }
    }
}
