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
            Spacer()
                .frame(maxHeight: 50)
            if let pathGambar = barang.pathGambar, let uiImage = UIImage(contentsOfFile: pathGambar) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .foregroundColor(.gray)
                    .background(Color.gray.opacity(0.2))
                    .clipped()
                    .cornerRadius(30)
            }

            VStack(alignment: .leading) {
                Text(barang.nama)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                Text("\(barang.deskripsi)")
                    .font(.body)
                Text("\(barang.kategori)")
                    .font(.body)
                Text("Harga: \(barang.harga, format: .currency(code: "IDR"))")
                    .font(.body)
                Text("Stok: \(barang.stok)")
                    .font(.body)
            }
//            .padding(.horizontal)

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

#Preview {
    DetailBarangView(barang: Barang(nama: "LB - Performance", deskripsi: "Liberty performance for Huracan LP - 410", kategori: "Body Kit", harga: 200000, stok: 100))
}

