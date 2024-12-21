//
//  CardList.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 13/12/24.
//

import SwiftUI

struct CardListBarang: View {
    let barang: Barang

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Foto Barang atau Placeholder
            Group {
                if let pathGambar = barang.pathGambar,
                   FileManager.default.fileExists(atPath: pathGambar),
                   let uiImage = UIImage(contentsOfFile: pathGambar) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 170, height: 140)
                        .clipped()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 170, height: 140)
                        .foregroundColor(.gray)
//                        .background(Color.gray.opacity(0.2))
                        .clipped()
                }
            }
            .cornerRadius(8)

            // Informasi Barang
            VStack(alignment: .leading, spacing: 4) {
                Text(barang.nama)
                    .font(.headline)
                    .lineLimit(1)

                Text(String(format: "IDR %.2f", barang.harga))
                    .font(.subheadline)
                    .foregroundColor(.black)

                // Stok dan Kategori
                HStack(spacing: 8) {
                    // Stok
                    HStack(spacing: 4) {
                        Image(systemName: "cube.box.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.blue)
                        Text("\(barang.stok)")
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.blue, lineWidth: 1)
                    )

                    // Kategori
                    HStack(spacing: 4) {
                        Image(systemName: "tag.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.green)
                        Text(barang.kategori)
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.green, lineWidth: 1)
                    )
                }
            }
            .padding(10)
        }
//        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

