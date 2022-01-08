//
//  SettingsEditImageView.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import SwiftUI


struct SettingsEditImageView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  
  @AppStorage(CurrentUserDefaultsKeys.userID) private var currentUserID: String?
  
  let title: String
  let description: String

  @State var selectedImage: UIImage
  @Binding var profileImage: UIImage
  
  @State private var isImagePickerDisplayed: Bool = false
  @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
  
  @State private var showSuccessAlert: Bool = false
  
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text(description)
        .multilineTextAlignment(.leading)
      

      // preview of the image
      Image(uiImage: selectedImage)
        .resizable()
        .scaledToFit()
        .frame(maxWidth: .infinity)
        .clipped()
        .cornerRadius(12)

      Button(action: {
        isImagePickerDisplayed.toggle()
      }) {
        Text("import".uppercased())
          .font(.title3)
          .fontWeight(.bold)
          .padding()
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          .background(Color.theme.yellow)
          .cornerRadius(12)
      }
      .accentColor(.theme.purple)
      .sheet(isPresented: $isImagePickerDisplayed) {
        ImagePicker(selectedImage: $selectedImage, sourceType: $sourceType)
      }
      
      Button(action: {
        saveImage()
      }) {
        Text("save".uppercased())
          .font(.title3)
          .fontWeight(.bold)
          .padding()
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          .background(Color.theme.purple)
          .cornerRadius(12)
      }
      .accentColor(.theme.yellow)
      
      Spacer()
    }
    .padding()
    .frame(maxWidth: .infinity)
    .navigationTitle(title)
    .alert(isPresented: $showSuccessAlert) {
      return Alert(title: Text("Successfully updated the profile image!"), message: nil, dismissButton: .default(Text("Ok"), action: {
        self.presentationMode.wrappedValue.dismiss()
      }))
    }
  }
}


extension SettingsEditImageView {
  
  func saveImage() {
    
    guard let userID = currentUserID else { return }
    
    // update the ui of the profile
    self.profileImage = self.selectedImage
    
    // update the profile image in the Firebase storage
    // saving a new image with the exact location so it overrides the file
    ImageManager.shared.uploadProfileImage(userID: userID, image: self.selectedImage)
    
    self.showSuccessAlert.toggle()
  }
}



struct SettingsEditImageView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SettingsEditImageView(
        title: "Title", description: "Description", selectedImage: UIImage(named: "dog1")!, profileImage: .constant(UIImage(named: "dog1")!)
      )
    }
  }
}
