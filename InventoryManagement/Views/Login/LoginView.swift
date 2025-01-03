//
//  LoginView.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 03/01/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String? // State untuk pesan error
    @State private var isLoginSuccessful = false // State untuk navigasi

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                // Menampilkan pesan error jika ada
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button(action: login) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Login")
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: 44)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .disabled(isLoading)

                Spacer()

                NavigationLink(destination: RegisterView()) {
                    Text("Don't have an account? Register")
                }

                // Navigasi ke DashboardView jika login berhasil
                NavigationLink(
                    destination: DashboardView(),
                    isActive: $isLoginSuccessful,
                    label: { EmptyView() }
                )
                .hidden()
            }
            .padding()
        }
    }

    private func login() {
        isLoading = true
        errorMessage = nil // Reset pesan error

        Task {
            do {
                let _ = try await AuthenticationManager.shared.login(email: email, password: password)
                isLoading = false
                isLoginSuccessful = true // Login berhasil
            } catch {
                isLoading = false
                errorMessage = "Invalid email or password. Please try again." // Tampilkan error
            }
        }
    }
}

