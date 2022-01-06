//
//  PostImageView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct PostImageView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  @Environment(\.colorScheme) private var colorScheme
  
  @State var captionText: String = ""
  @Binding var selectedImage: UIImage
  
  
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
    }
  }
}


extension PostImageView {
  
  func postPicture() {
    
  }
}



struct PostImageView_Previews: PreviewProvider {
  
  @State static var image = UIImage(named: "dog1")!
  
  static var previews: some View {
    PostImageView(selectedImage: $image)
  }
}
