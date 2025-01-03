//
//  RegisterView.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 03/01/25.
//

import SwiftUI
import FirebaseAuth

@MainActor
final class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String? // Untuk pesan error
    @Published var showSuccessAlert = false // Untuk alert sukses

    func register() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email or Password cannot be empty"
            return
        }

        do {
            let _ = try await AuthenticationManager.shared.createUser(email: email, password: password)
            errorMessage = nil
            showSuccessAlert = true // Tampilkan alert sukses
        } catch let error as NSError {
            // Tangkap error spesifik untuk akun yang sudah ada
            if error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                errorMessage = "This email is already registered."
            } else {
                errorMessage = "Failed to register. Please try again."
            }
        }
    }
}

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var registerViewModel = RegisterViewModel()
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $registerViewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $registerViewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Menampilkan pesan error jika ada
            if let errorMessage = registerViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button {
                Task {
                    isLoading = true
                    await registerViewModel.register()
                    isLoading = false
                }
            } label: {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Register")
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .disabled(isLoading)

            Spacer()

            Button(action: {
                presentationMode.wrappedValue.dismiss() // Dismiss halaman
            }) {
                Text("Already have an account? Login")
                    .foregroundColor(.blue)
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
        .alert("Registration Successful", isPresented: $registerViewModel.showSuccessAlert) {
            Button("OK") {
                presentationMode.wrappedValue.dismiss() // Dismiss setelah sukses
            }
        } message: {
            Text("Your account has been created successfully. Please log in.")
        }
    }
}

