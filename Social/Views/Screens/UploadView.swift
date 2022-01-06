//
//  UploadView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI
import UIKit


struct UploadView: View {
  
  @Environment(\.colorScheme) private var colorScheme
  
  @State var isImagePickerDisplayed: Bool = false
  @State var selectedImage: UIImage = UIImage(named: "logo")!
  @State var sourceType: UIImagePickerController.SourceType = .camera
  @State var isPostImageViewDisplayed: Bool = false
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        Button(action: {
          sourceType = .camera
          isImagePickerDisplayed.toggle()
        }) {
          Text("Take photo".uppercased())
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.theme.yellow)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.purple)
        
        Button(action: {
          sourceType = .photoLibrary
          isImagePickerDisplayed.toggle()
        }) {
          Text("Import photo".uppercased())
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.theme.purple)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.yellow)
        
      }
      .sheet(isPresented: $isImagePickerDisplayed, onDismiss: {
        isPostImageViewDisplayed.toggle() // move the post image view
        isImagePickerDisplayed = false
      }) {
        ImagePicker(selectedImage: $selectedImage, sourceType: $sourceType)
          .accentColor(colorScheme == .light ? .theme.purple : .theme.yellow)
      }
      
      Image("logo.transparent")
        .resizable()
        .frame(width: 200, height: 200, alignment: .center)
        .shadow(radius: 12)
    }
    .edgesIgnoringSafeArea(.top)
    .fullScreenCover(isPresented: $isPostImageViewDisplayed, onDismiss: {
      isPostImageViewDisplayed = false
    }) {
      PostImageView(selectedImage: $selectedImage)
    }
  }
}



struct UploadView_Previews: PreviewProvider {
  static var previews: some View {
    UploadView()
  }
}
