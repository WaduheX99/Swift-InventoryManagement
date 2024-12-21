//
//  DetailSupplierView.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 21/12/24.
//

import SwiftUI

struct DetailSupplierView: View {
    let supplier: Supplier

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Nama: \(supplier.nama)")
                .font(.title)
                .padding(.bottom, 4)
            Text("Alamat: \(supplier.alamat)")
                .font(.body)
                .padding(.bottom, 4)
            Text("No. Telepon: \(supplier.noTelp)")
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationTitle("Detail Supplier")
    }
}
