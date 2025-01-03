//
//  InventoryManagementApp.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 11/12/24.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct InventoryManagementApp: App {
    init() {
        FirebaseApp.configure()
        print("Firebase App Initialized")
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .modelContainer(for: [Barang.self, RiwayatTransaksi.self, Supplier.self])
        }
    }
}
