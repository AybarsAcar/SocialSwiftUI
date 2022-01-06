//
//  SettingsEditImageView.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import SwiftUI


struct SettingsEditImageView: View {
  
  let title: String
  let description: String

  @State var selectedImage: UIImage
  
  @State private var isImagePickerDisplayed: Bool = false
  @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
  
  
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
      
      Button(action: {}) {
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
  }
}



struct SettingsEditImageView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SettingsEditImageView(title: "Title", description: "Description", selectedImage: UIImage(named: "dog1")!)
    }
  }
}
