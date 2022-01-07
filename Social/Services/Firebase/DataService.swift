//
//  DataService.swift
//  Social
//
//  Created by Aybars Acar on 7/1/2022.
//

import Foundation
import SwiftUI
import FirebaseFirestore


/// used to handle uploading and downloading data other than User to our Database
class DataService {
  
  static let shared = DataService()
  private init() { }
  
  private var REF_POSTS = DATABASE.collection("posts")
  
  /// displayName and userID is the currently logged in user who
  /// creates the post
  func uploadPost(image: UIImage, caption: String?, displayName: String, userID: String, handler: @escaping (_ success: Bool) -> Void) {
    
    let document = REF_POSTS.document()
    let postID = document.documentID
    
    // upload image to storage
    ImageManager.shared.uploadPostImage(postID: postID, image: image) { succes in
      
      if succes {
        // successfully uploaded image data to Storage
        // now upload post data to Database
        let postData: [String: Any] = [
          DatabasePostField.postID: postID,
          DatabasePostField.userID: userID,
          DatabasePostField.displayName: displayName,
          DatabasePostField.caption: caption,
          DatabasePostField.createdAt: FieldValue.serverTimestamp()
        ]
        
        document.setData(postData) { error in
          if let error = error {
            print("error uploading data to post document:\n\(error)")
            handler(false)
            return
          }
          
          // return back to the app
          handler(true)

        }
      } else {
        // error
        print("error uploading post image to firebase")
        handler(false)
      }
    }
  }
}
