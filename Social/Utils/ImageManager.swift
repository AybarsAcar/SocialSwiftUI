//
//  ImageManager.swift
//  Social
//
//  Created by Aybars Acar on 7/1/2022.
//

import Foundation
import FirebaseStorage


class ImageManager {
  
  static let shared = ImageManager()
  private init() { }
  
  private var REF_STORE = Storage.storage()
  
  
  func uploadProfileImage(userID: String, image: UIImage) {
    // get the path where image will be saved
    let path = getProfileImagePath(userID: userID)
    
    // save image to path
    uploadImage(to: path, image: image) { _ in
      
    }
  }
  
  
  /// returns the path for the profile image based on the userID
  private func getProfileImagePath(userID: String) -> StorageReference {
    
    let userPath = "users/\(userID)/profile"
    
    return REF_STORE.reference(withPath: userPath)
  }
  
  /// uploads the image to the path
  private func uploadImage(to path: StorageReference, image: UIImage, handler: @escaping (_ success: Bool) -> Void) {
    
    // maximum file size allowed in our app for image upload
    let maxFileSize: Int = 240 * 240
    let maxCompression: CGFloat = 0.05 // 5% of the original
    
    // compression rate - 1.0 -> no compression, 0.1 -> 10% quality
    var compression: CGFloat = 1.0
    
    
    guard var imageData = image.jpegData(compressionQuality: compression) else {
      print("error getting data from image")
      handler(false)
      return
    }
    
    // check for maximum file size
    while (imageData.count > maxFileSize) && (compression > maxCompression) {
      // lower the compression
      compression -= 0.05
      if let compressedData = image.jpegData(compressionQuality: compression) {
        imageData = compressedData
      }
    }
    
    
    // get photo metadata
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpeg"
    
    // save data to path
    path.putData(imageData, metadata: metaData) { _, error in
      
      if let error = error {
        print("error uploading image\n\(error)")
        handler(false)
        return
      }
      
      // success
      handler(true)
    }
  }
}
