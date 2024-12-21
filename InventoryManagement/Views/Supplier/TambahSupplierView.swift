//
//  TambahSupplier.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 21/12/24.
//

import SwiftUI

struct TambahSupplierView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    @State private var nama: String = ""
    @State private var alamat: String = ""
    @State private var noTelp: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informasi Supplier")) {
                    TextField("Nama Supplier", text: $nama)
                    TextField("Alamat", text: $alamat)
                    TextField("No. Telepon", text: $noTelp)
                        .keyboardType(.phonePad)
                }
                
                Section {
                    Button("Simpan") {
                        simpanSupplier()
                    }
                }
            }
            .navigationTitle("Tambah Supplier")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Batal") {
                        dismiss()
                    }
                }
            }
        }
    }

    func simpanSupplier() {
        let supplier = Supplier(nama: nama, alamat: alamat, noTelp: noTelp)
        context.insert(supplier)
        try? context.save()
        dismiss()
    }
}
