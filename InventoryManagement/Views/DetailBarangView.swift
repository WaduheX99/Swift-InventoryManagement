//
//  DetailBarang.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 11/12/24.
//

import SwiftUI

struct DetailBarangView: View {
    @Environment(\.modelContext) var context
    @ObservedObject var barang: Barang

    @State private var tampilkanTambahRiwayat = false

    var body: some View {
        VStack {
            if let pathGambar = barang.pathGambar, let uiImage = UIImage(contentsOfFile: pathGambar) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }

            Text(barang.nama).font(.largeTitle)
            Text("Deskripsi: \(barang.deskripsi)")
            Text("Kategori: \(barang.kategori)")
            Text("Harga: \(barang.harga, format: .currency(code: "IDR"))")
            Text("Stok: \(barang.stok)")

            List(barang.riwayat) { riwayat in
                HStack {
                    Text(riwayat.jenis.capitalized)
                    Spacer()
                    Text("\(riwayat.jumlah)")
                }
            }

            // Floating Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { tampilkanTambahRiwayat = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.green)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                    .sheet(isPresented: $tampilkanTambahRiwayat) {
                        TambahRiwayatView(barang: barang)
                    }
                }
            }
        }
        .navigationTitle(barang.nama)
    }
}
