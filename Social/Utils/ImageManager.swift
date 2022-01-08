//
//  ImageManager.swift
//  Social
//
//  Created by Aybars Acar on 7/1/2022.
//

import Foundation
import FirebaseStorage
import SwiftUI


// initialise a blank image cache
let imageCache = NSCache<AnyObject, UIImage>()


class ImageManager {
  
  static let shared = ImageManager()
  private init() { }
  
  private var REF_STORE = Storage.storage()
  
  
  func uploadProfileImage(userID: String, image: UIImage) {
    // get the path where image will be saved
    let path = getProfileImagePath(userID: userID)
    
    // clear the cache for the profile image so it will download the profile image for the other screen
    // we want to download the image again when the profile image is updated
    imageCache.removeObject(forKey: path)
    
    // save image to path
    DispatchQueue.global(qos: .userInteractive).async {
      self.uploadImage(to: path, image: image) { _ in
      }
    }
  }
  
  
  func uploadPostImage(postID: String, image: UIImage, handler: @escaping (_ succes: Bool) -> Void) {
    // get the path where image will be saved
    let path = getPostImagePath(postID: postID)
    
    // save image to path
    DispatchQueue.global(qos: .userInteractive).async {
      self.uploadImage(to: path, image: image) { success in
        
        DispatchQueue.main.async {
          handler(success)
        }
      }
    }
  }
  
  
  func downloadProfileImage(userID: String, handler: @escaping (_ image: UIImage?) -> Void) {
    // get the path
    let path = getProfileImagePath(userID: userID)
    
    // download from the path
    DispatchQueue.global(qos: .userInteractive).async {
      self.downloadImage(from: path) { image in
        DispatchQueue.main.async {
          handler(image)
        }
      }
    }
  }
  
  
  func downloadPostImage(postID: String, handler: @escaping (_ image: UIImage?) -> Void) {
    // get the path
    let path = getPostImagePath(postID: postID)
    
    // download from the path
    DispatchQueue.global(qos: .userInteractive).async {
      self.downloadImage(from: path) { image in
        DispatchQueue.main.async {
          handler(image)
        }
      }
    }
  }
  
  
  /// returns the path for the profile image based on the userID
  private func getProfileImagePath(userID: String) -> StorageReference {
    
    let userPath = "users/\(userID)/profile"
    
    return REF_STORE.reference(withPath: userPath)
  }
  
  
  private func getPostImagePath(postID: String) -> StorageReference {
    
    // 1 becuase we will be posting 1 image per post
    // we can make this number a variable and create posts with multiple pictures
    let postPath = "posts/\(postID)/1"
    
    return REF_STORE.reference(withPath: postPath)
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
  
  
  /// downloads an image given a path
  private func downloadImage(from path: StorageReference, handler: @escaping (_ image: UIImage?) -> Void) {
    
    // check if the image is already in the cache
    if let cachedImage = imageCache.object(forKey: path) {
      // image exists in cache return early
      handler(cachedImage)
      return
    }
    
    path.getData(maxSize: 27 * 1024 * 1024) { imageData, error in
      
      if let data = imageData, let image = UIImage(data: data) {
        // success getting image data - cache it first
        imageCache.setObject(image, forKey: path)
        
        handler(image)
        return
      }
      
      print("error getting data from path for image")
      handler(nil)
    }
  }
}
