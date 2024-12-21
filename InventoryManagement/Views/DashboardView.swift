//
//  DashboardView.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 21/12/24.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) var context
    @Query var barang: [Barang]
    @Query var suppliers: [Supplier]

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                

                HStack(spacing: 16) {
                    // Kotak Jumlah Barang
                    NavigationLink(destination: DaftarBarangView()) {
                        VStack {
                            Text("Jumlah Barang")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("\(barang.count)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    }

                    // Kotak Jumlah Supplier
                    NavigationLink(destination: DaftarSupplierView()) {
                        VStack {
                            Text("Jumlah Supplier")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("\(suppliers.count)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                    }
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Dashboard")
        }
    }
}

