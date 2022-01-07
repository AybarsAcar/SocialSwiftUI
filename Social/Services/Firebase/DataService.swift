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
  
  @AppStorage(CurrentUserDefaultsKeys.userID) private var currentUserID: String?
  
  
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
  
  
  /// downloads the posts by user id
  func downloadPostsForUser(userID: String, handler: @escaping (_ posts: [Post]) -> Void) {
    
    REF_POSTS.whereField(DatabasePostField.userID, isEqualTo: userID).getDocuments { querySnapshot, error in
 
      handler(self.getPostsFromSnapshot(querySnapshot))
    }
  }
  
  
  /// downloads all the posts
  /// gets the most recent posts
  func downloadPostsForFeed(handler: @escaping (_ posts: [Post]) -> Void) {
    
    // get the latest 50 posts
    REF_POSTS.order(by: DatabasePostField.createdAt, descending: true).limit(to: 50).getDocuments { querySnapshot, error in

      handler(self.getPostsFromSnapshot(querySnapshot))
    }    
  }
  
  
  /// function to handle the like a post by its id by the user with their id
  func likePost(postID: String, currentUserID: String) {
    
    // update the like count and
    // update the array of users who liked the post
    let data: [String: Any] = [
      DatabasePostField.likeCount: FieldValue.increment(1 as Int64),
      DatabasePostField.likedBy: FieldValue.arrayUnion([currentUserID])
    ]
    
    REF_POSTS.document(postID).updateData(data)
  }
  
  
  func unLikePost(postID: String, currentUserID: String) {
    
    // update the like count and
    // update the array of users who liked the post
    let data: [String: Any] = [
      DatabasePostField.likeCount: FieldValue.increment(-1 as Int64),
      DatabasePostField.likedBy: FieldValue.arrayRemove([currentUserID])
    ]
    
    REF_POSTS.document(postID).updateData(data)
  }
  
  
  private func getPostsFromSnapshot(_ querySnapshot: QuerySnapshot?) -> [Post] {
    
    var postArray: [Post] = []
    
    if let snapshot = querySnapshot, snapshot.documents.count > 0 {
      
      for document in snapshot.documents {
        
        if let userID = document.get(DatabasePostField.userID) as? String,
           let displayName = document.get(DatabasePostField.displayName) as? String,
           let timestamp = document.get(DatabasePostField.createdAt) as? Timestamp {
          
          let caption = document.get(DatabasePostField.caption) as? String
          let postID = document.documentID
          
          let likeCount = document.get(DatabasePostField.likeCount) as? Int ?? 0
          
          var likedByUser = false
          
          if let userIDArray = document.get(DatabasePostField.likedBy) as? [String],
             let currentUserID = self.currentUserID {
            
            likedByUser = userIDArray.contains(currentUserID)
          }
          
          let post = Post(postID: postID, userID: userID, username: displayName, caption: caption, createdAt: timestamp.dateValue(), likeCount: likeCount, isLikedByUser: likedByUser)
          
          postArray.append(post)
        }
      }
    } else {
      print("No documents found for the user")
    }
    
    return postArray
  }
}
