//
//  DaftarSupplierView.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 21/12/24.
//

import SwiftUI
import SwiftData

struct DaftarSupplierView: View {
    @Environment(\.modelContext) var context
    @Query var suppliers: [Supplier]

    @State private var tampilkanTambahSupplier = false

    var body: some View {
        NavigationView {
            ZStack {
                List(suppliers) { supplier in
                    NavigationLink(destination: DetailSupplierView(supplier: supplier)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(supplier.nama)
                                    .font(.headline)
                                Text(supplier.alamat)
                                    .font(.subheadline)
                                    .lineLimit(1)
                                Text(supplier.noTelp)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .navigationTitle("Daftar Supplier")

                // Tombol Floating untuk tambah supplier
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { tampilkanTambahSupplier = true }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                        .sheet(isPresented: $tampilkanTambahSupplier) {
                            TambahSupplierView()
                        }
                    }
                }
            }
        }
    }
}
