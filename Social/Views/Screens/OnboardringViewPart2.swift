//
//  OnboardringViewPart2.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import SwiftUI


struct OnboardringViewPart2: View {
  
  @State private var displayName: String = ""
  @State private var isImagePickerDisplayed: Bool = false
  
  // image picker
  @State private var selectedImage: UIImage = UIImage(named: "logo")!
  @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
  
  
  var body: some View {
    VStack(alignment: .center, spacing: 20) {
      Text("What's your name?")
        .font(.title)
        .fontWeight(.semibold)
        .foregroundColor(.theme.yellow)
      
      TextField("Add your name here...", text: $displayName)
        .padding()
        .foregroundColor(.black)
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background(Color.theme.beige)
        .cornerRadius(12)
        .font(.headline)
        .autocapitalization(.sentences)
        .padding(.horizontal)
      
      Button(action: {
        isImagePickerDisplayed.toggle()
      }) {
        Text("Finish: Add profile picture")
          .font(.headline)
          .fontWeight(.semibold)
          .padding()
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          .background(Color.theme.yellow)
          .cornerRadius(12)
          .padding(.horizontal)
      }
      .accentColor(.theme.purple)
      .disabled(displayName.isEmpty)
      .animation(.easeInOut(duration: 1.0), value: displayName.isEmpty)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.theme.purple)
    .edgesIgnoringSafeArea(.all)
    .sheet(isPresented: $isImagePickerDisplayed, onDismiss: createProfile) {
      ImagePicker(selectedImage: $selectedImage, sourceType: $sourceType)
    }
  }
}


extension OnboardringViewPart2 {
  
  func createProfile() {
    
  }
}



struct OnboardringViewPart2_Previews: PreviewProvider {
  static var previews: some View {
    OnboardringViewPart2()
  }
}
