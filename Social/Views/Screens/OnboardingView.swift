//
//  OnboardingView.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import SwiftUI


struct OnboardingView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  
  @State private var isOnboardingPart2Displayed: Bool = false
  @State var showError: Bool = false
  @State var errorMessage: String? = nil
  @State var isLoading: Bool = false
  
  
  var body: some View {
    VStack(spacing: 10) {
      
      Image("logo.transparent")
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 100, alignment: .center)
        .shadow(radius: 12)
      
      Text("Welcome to DogGram!")
        .font(.largeTitle)
        .fontWeight(.semibold)
        .foregroundColor(.theme.purple)
      
      Text("DogGram is the #1 app for posting pictures of your dog and sharing them across the world. We are a dog-loving community and we're happy to welcome you")
        .font(.callout)
        .multilineTextAlignment(.center)
        .foregroundColor(.theme.purple)
        .padding()
      
      Button(action: {
        isOnboardingPart2Displayed.toggle()
      }) {
        SignInWithAppleButton()
          .frame(height: 60)
          .frame(maxWidth: .infinity)
      }
      
      Button(action: {
        SignInWithGoogle.shared.signIn(view: self)
      }) {
        HStack {
          Image(systemName: "globe")
          
          Text("Sign in with Google")
          
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255, opacity: 1.0))
        .cornerRadius(6)
        .font(.system(size: 23, weight: .medium, design: .default))
        
      }
      .accentColor(.white)
      
      Button(action: {
        presentationMode.wrappedValue.dismiss()
      }) {
        Text("Continue as guest".uppercased())
          .font(.headline)
          .fontWeight(.medium)
          .padding()
      }
      .accentColor(.secondary)
      
      
    }
    .padding(20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.theme.beige)
    .edgesIgnoringSafeArea(.all)
    .fullScreenCover(isPresented: $isOnboardingPart2Displayed) {
      OnboardringViewPart2()
    }
    .alert(isPresented: $showError) {
      return Alert(title: Text("Error Signing in"), message: Text("Unexpected Error occurred when signing in"))
    }
  }
}



struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
