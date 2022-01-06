//
//  SignUpView.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import SwiftUI


struct SignUpView: View {
  
  @State private var isOnboardingDisplayed: Bool = false
  
  var body: some View {
    VStack(alignment: .center, spacing: 20) {
      
      Spacer()
      
      Image("logo.transparent")
        .resizable()
        .scaledToFill()
        .frame(width: 100, height: 100)
      
      Text("You're not signed in! 🙁")
        .font(.largeTitle)
        .fontWeight(.semibold)
        .lineLimit(1)
        .minimumScaleFactor(0.5) // downsize the font to fit in one line
        .foregroundColor(.theme.purple)
      
      Text("Click the button below to create an account and join the fun!")
        .font(.headline)
        .fontWeight(.medium)
        .multilineTextAlignment(.center)
        .foregroundColor(.theme.purple)
      
      Button(action: {
        isOnboardingDisplayed.toggle()
      }) {
        Text("Sign in / Sign up".uppercased())
          .font(.title3)
          .fontWeight(.bold)
          .padding()
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          .background(Color.theme.purple)
          .cornerRadius(12)
          .shadow(color: .black.opacity(0.7), radius: 12, x: 0, y: 12)
      }
      .accentColor(.theme.yellow)
      
      Spacer()
      Spacer()
    }
    .padding(40)
    .background(Color.theme.yellow.edgesIgnoringSafeArea(.all))
    .fullScreenCover(isPresented: $isOnboardingDisplayed) {
      OnboardingView()
    }
  }
}



struct SignUpView_Previews: PreviewProvider {
  static var previews: some View {
    SignUpView()
  }
}
