//
//  LoginSignupView.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 22.10.21.
//

import Foundation

import Combine
import SwiftUI

enum AuthState {
    case signUp
    case signIn
}

struct LoginSignupView: View {
    @State private var authState: AuthState = .signUp
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var validationError = false
    @State private var requestError = false
    @State private var requestErrorText: String = ""
    @State var networkOperation: AnyCancellable?

    var body: some View {
        VStack(spacing: 48) {
            AppTitle()
            let columns: [GridItem] = [
                GridItem(.flexible(), spacing: 8, alignment: .leading),
                GridItem(.flexible())
            ]

            LazyVGrid(columns: columns) {
                Text("Username")
                TextField("Username", text: $username)
                    .textContentType(.username)
                if authState == .signUp {
                    Text("Email")
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                }
                Text("Password")
                SecureField("Password", text: $password)
                    .textContentType(.password)
            }
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 18)

            VStack(spacing: 8) {
                Button {
                    doAuth()
                } label: {
                    HStack {
                        Spacer()
                        Text(authState == .signUp ? "Sign Up" : "Sign In")
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .padding([.top, .bottom], 10)
                .background(Color.accentGreen.opacity(0.2))
                .clipShape(Capsule())
                .alert(isPresented: $validationError) {
                    Alert(title: Text("Please enter valid credentials"))
                }

                Button {
                    withAnimation {
                        toggleState()
                    }
                } label: {
                    Spacer()
                    Text(authState == .signUp ? "Sign In" : "Sign Up")
                    Spacer()
                }
                .padding([.top, .bottom], 10)
                .overlay(Capsule().stroke(Color.accentGreen, lineWidth: 2))
                .alert(isPresented: $requestError) {
                    Alert(title: Text(requestErrorText))
                }
            }
            .padding(.horizontal, 50)
            .accentColor(Color.green)
            Spacer()
                .frame(maxHeight: 100)
        }
    }

    private func toggleState() {
        authState = (authState == .signUp ? .signIn : .signUp)
    }

    private func doAuth() {
        networkOperation?.cancel()
        switch authState {
        case .signIn:
            doSignIn()
        case .signUp:
            doSignUp()
        }
    }

    private func doSignIn() {
        guard username.count > 2, password.count > 4 else {
            validationError = true
            return
        }

        let client = APIClient()
        let request = SignInUserRequest(username: username, password: password)
        networkOperation = client.publisherForRequest(request)
            .sink(receiveCompletion: { result in
                handleResult(result)
            }, receiveValue: { _ in })
    }

    private func doSignUp() {
        guard username.count > 2, email.count > 4, password.count > 4 else {
            validationError = true
            return
        }

        let client = APIClient()
        let request = SignUpUserRequest(username: username, email: email, password: password)
        networkOperation = client.publisherForRequest(request)
            .sink(receiveCompletion: { result in
                handleResult(result)
            }, receiveValue: { _ in })
    }

    private func handleResult(_ result: Subscribers.Completion<Error>) {
        if case .failure(let error) = result {
            // TODO: check for 401 and show a nicer error
            switch error {
            case APIError.requestFailed(let statusCode):
                requestErrorText = "Status code: \(statusCode)"
            case APIError.postProcessingFailed(let innerError):
                requestErrorText = "Error: \(String(innerError?.localizedDescription ?? "unknown error"))"
            default:
                requestErrorText = "An error occurred: \(String(describing: error))"
            }
        } else {
            requestErrorText = ""
            networkOperation = nil
        }
        requestError = requestErrorText.count > 0
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignupView()
            .preferredColorScheme(.light)
    }
}
