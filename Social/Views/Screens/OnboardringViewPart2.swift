//
//  OnboardringViewPart2.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import SwiftUI


struct OnboardringViewPart2: View {
  
  @Environment(\.presentationMode) private var presentationMode
  
  @Binding var displayName: String
  @Binding var email: String
  @Binding var providerID: String
  @Binding var provider: String
  
  @State private var isImagePickerDisplayed: Bool = false
  
  // image picker
  @State private var selectedImage: UIImage = UIImage(named: "logo")!
  @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
  
  @State private var showError: Bool = false
  
  
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
    .alert("Error ocurred creating user profile", isPresented: $showError) {
      Button("Cancel") {
        showError.toggle()
      }
    }
  }
}


extension OnboardringViewPart2 {
  
  func createProfile() {
    AuthService.shared.createNewUserInDatabase(
      name: displayName,
      email: email,
      providerID: providerID,
      provider: provider,
      profileImage: selectedImage
    ) { userID in
      
      if let userID = userID {
        // success - log the user in
        AuthService.shared.loginUserToApp(userID: userID) { success in
          if success {
            // we will dismiss the on boarding views
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              self.presentationMode.wrappedValue.dismiss()
            }
            
          } else {
            print("error logging in")
            self.showError.toggle()
          }
        }
      } else {
        // error ocurred creating user in database
        print("Error creating user profile in the database")
        showError.toggle()
      }
    }
  }
}



struct OnboardringViewPart2_Previews: PreviewProvider {
  static var previews: some View {
    OnboardringViewPart2(displayName: .constant("Test name"), email: .constant("Test email"), providerID: .constant("Test provider id"), provider: .constant("test provider"))
  }
}
