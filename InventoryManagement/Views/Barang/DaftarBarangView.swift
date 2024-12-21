//
//  DaftarBarangView.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 11/12/24.
//

import SwiftUI
import SwiftData

struct DaftarBarangView: View {
    @Environment(\.modelContext) var context
    @Query var barang: [Barang]

    @State private var tampilkanTambahBarang = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Grid Tampilan Barang
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(barang) { item in
                            NavigationLink(destination: DetailBarangView(barang: item)) {
                                CardListBarang(barang: item)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Daftar Barang")

                // Tombol Floating untuk tambah barang
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { tampilkanTambahBarang = true }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                        .sheet(isPresented: $tampilkanTambahBarang) {
                            TambahBarangView()
                        }
                    }
                }
            }
        }
    }
}
