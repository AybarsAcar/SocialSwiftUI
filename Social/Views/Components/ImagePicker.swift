//
//  ImagePicker.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import Foundation
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
  
  @Environment(\.presentationMode) var presentationMode
  
  @Binding var selectedImage: UIImage
  @Binding var sourceType: UIImagePickerController.SourceType
  
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> some UIImagePickerController {
    // create the picker
    let picker = UIImagePickerController()
    
    // customise it
    picker.delegate = context.coordinator
    picker.sourceType = sourceType
    picker.allowsEditing = true
    
    return picker
  }
  
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) { }
  
  
  func makeCoordinator() -> ImagePickerCoordinator {
    return ImagePickerCoordinator(parent: self)
  }
  
  
  class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let parent: ImagePicker
    
    init(parent: ImagePicker) {
      self.parent = parent
    }
    
    
    /// this method is called after the user finishes picking the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
      // access the dictionary with the editedImage key and try converting it into UIImage
      // if we can't get an edited image get the original image and cast it as UIImage
      if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
        
        // select the image for the app
        parent.selectedImage = image
        
        // dismiss the screen for the picker
        parent.presentationMode.wrappedValue.dismiss()
      }
    }
  }
}
