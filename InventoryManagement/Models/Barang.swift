//
//  Barang.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 11/12/24.
//

import SwiftData
import Foundation

@Model
class Barang : ObservableObject {
    var id: UUID = UUID()
    var nama: String
    var deskripsi: String
    var kategori: String
    var harga: Double
    var stok: Int
    var pathGambar: String?
    var riwayat: [RiwayatTransaksi] = []

    init(nama: String, deskripsi: String, kategori: String, harga: Double, stok: Int, pathGambar: String? = nil) {
        self.nama = nama
        self.deskripsi = deskripsi
        self.kategori = kategori
        self.harga = harga
        self.stok = stok
        self.pathGambar = pathGambar
    }
}

@Model
class RiwayatTransaksi {
    var id: UUID = UUID()
    var jenis: String // "masuk" atau "keluar"
    var jumlah: Int
    var tanggal: Date
    var barang: Barang?

    init(jenis: String, jumlah: Int, tanggal: Date) {
        self.jenis = jenis
        self.jumlah = jumlah
        self.tanggal = tanggal
    }
}
