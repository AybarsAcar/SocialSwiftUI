//
//  PostImageView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct PostImageView: View {
  
  @AppStorage(CurrentUserDefaultsKeys.userID) private var currentUserID: String?
  @AppStorage(CurrentUserDefaultsKeys.displayName) private var currentUserDisplayName: String?
  
  @Environment(\.presentationMode) private var presentationMode
  @Environment(\.colorScheme) private var colorScheme
  
  @State var captionText: String = ""
  @Binding var selectedImage: UIImage
  
  @State private var showAlert: Bool = false
  @State private var postUploadedSuccessfully: Bool = false
  
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      
      HStack() {
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }) {
          Image(systemName: "xmark")
            .font(.title)
            .padding()
        }
        .accentColor(.primary)
        
        Spacer()
      }
      
      ScrollView(.vertical, showsIndicators: false) {
        
        Image(uiImage: selectedImage)
          .resizable()
          .scaledToFill()
          .frame(width: 200, height: 200, alignment: .center)
          .cornerRadius(12)
          .clipped()
        
        TextField("Add your caption here...", text: $captionText)
          .font(.headline)
          .padding()
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          .background(colorScheme == .light ? Color.theme.beige : Color.theme.purple)
          .cornerRadius(12)
          .padding(.horizontal)
          .autocapitalization(.sentences)
        
        Button(action: {
          postPicture()
        }) {
          Text("Post Picture!".uppercased())
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(colorScheme == .light ? Color.theme.purple : Color.theme.yellow)
            .cornerRadius(12)
            .padding(.horizontal)
        }
        .accentColor(colorScheme == .light ? .theme.yellow : .theme.purple)
      }
      .alert(isPresented: $showAlert) {
        getAlert()
      }
    }
  }
}


extension PostImageView {
  
  func postPicture() {
    
    guard let userID = currentUserID, let displayName = currentUserDisplayName else { return }
    
    DataService.shared.uploadPost(image: selectedImage, caption: captionText, displayName: displayName, userID: userID) { success in
      // update the local variable
      self.postUploadedSuccessfully = success
      self.showAlert.toggle()
    }
  }
  
  
  /// for which alert to return
  private func getAlert() -> Alert {
    if postUploadedSuccessfully {
      return Alert(title: Text("Successfully uploaded post! 🥳"), message: nil, dismissButton: .default(Text("Ok"), action: {
        // dismiss the post image view
        self.presentationMode.wrappedValue.dismiss()
      }))
    }
    
    return Alert(title: Text("Error uploading post 😭"), message: nil, dismissButton: .default(Text("Ok")))
  }
}



struct PostImageView_Previews: PreviewProvider {
  
  @State static var image = UIImage(named: "dog1")!
  
  static var previews: some View {
    PostImageView(selectedImage: $image)
  }
}
