//
//  CardList.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 13/12/24.
//

import SwiftUI

struct CardList: View {
    let barang: Barang

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Foto Barang atau Placeholder
            Group {
                if let pathGambar = barang.pathGambar,
                   let uiImage = UIImage(contentsOfFile: pathGambar) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .clipped()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.2))
                        .clipped()
                }
            }
            .cornerRadius(8)

            // Informasi Barang
            VStack(alignment: .leading, spacing: 4) {
                Text(barang.nama)
                    .font(.headline)
                    .lineLimit(1)
                Text("\(barang.kategori)")
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text("Stok : \(barang.stok)")
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(String(format: "Rp%.2f", barang.harga))
                    .font(.subheadline)
                    .foregroundColor(.accentColor)
            }
            .padding(.horizontal, 4)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
