//
//  TambahBarang.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 11/12/24.
//

import SwiftUI
import PhotosUI

struct TambahBarangView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    @State private var nama: String = ""
    @State private var deskripsi: String = ""
    @State private var kategori: String = ""
    @State private var harga: String = ""
    @State private var stok: String = ""
    @State private var imageSelection: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil // Data untuk gambar yang dipilih
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informasi Barang")) {
                    TextField("Nama Barang", text: $nama)
                    TextField("Deskripsi", text: $deskripsi)
                    TextField("Kategori", text: $kategori)
                    TextField("Harga", text: $harga)
                        .keyboardType(.numberPad)
                    TextField("Stok", text: $stok)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Gambar Barang")) {
                    PhotosPicker(
                        selection: $imageSelection,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        HStack {
                            if let imageData = selectedImageData,
                               let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(8)
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                                    .cornerRadius(8)
                            }
                            Text("Pilih Gambar")
                        }
                    }
                    .onChange(of: imageSelection) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tambah Barang")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Simpan") {
                        simpanBarang()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Batal") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func simpanBarang() {
        // Simpan gambar ke direktori dokumen
        var pathGambar: String? = nil
        if let imageData = selectedImageData {
            pathGambar = simpanGambar(data: imageData)
        }
        
        if let stokINT = Int(stok), let hargaINT = Double(harga) {
            // Simpan barang ke SwiftData
            let barang = Barang(
                nama: nama,
                deskripsi: deskripsi,
                kategori: kategori,
                harga: hargaINT,
                stok: stokINT,
                pathGambar: pathGambar
            )
            context.insert(barang)
            try? context.save()
            dismiss()
        }
        
        
    }
    
    func simpanGambar(data: Data) -> String? {
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileName = "\(UUID().uuidString).jpg"
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch {
            print("Gagal menyimpan gambar: \(error.localizedDescription)")
            return nil
        }
    }
}



