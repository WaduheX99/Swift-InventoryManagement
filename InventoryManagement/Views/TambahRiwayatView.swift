//
//  TambahRiwayat.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 11/12/24.
//

import SwiftUI
import SwiftData

struct TambahRiwayatView: View {
    @Environment(\.dismiss) var tutup
    @Environment(\.modelContext) var context

    @ObservedObject var barang: Barang

    @State private var jenis = "masuk"
    @State private var jumlah: Int = 0
    @State private var tanggal = Date()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Jenis Transaksi", selection: $jenis) {
                        Text("Masuk").tag("masuk")
                        Text("Keluar").tag("keluar")
                    }
                    TextField("Jumlah", value: $jumlah, format: .number)
                    DatePicker("Tanggal", selection: $tanggal, displayedComponents: .date)
                }
            }
            .navigationTitle("Tambah Riwayat")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Batal") { tutup() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Simpan") {
                        let riwayatBaru = RiwayatTransaksi(jenis: jenis, jumlah: jumlah, tanggal: tanggal)
                        riwayatBaru.barang = barang
                        context.insert(riwayatBaru)

                        if jenis == "masuk" {
                            barang.stok += jumlah
                        } else {
                            barang.stok -= jumlah
                        }

                        try? context.save()
                        tutup()
                    }
                }
            }
        }
    }
}
