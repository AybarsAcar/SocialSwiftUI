//
//  SignInWithAppleButton.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import Foundation
import SwiftUI
import AuthenticationServices


struct SignInWithAppleButton: UIViewRepresentable {
  
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    return ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
  }
  
  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) { }
}
