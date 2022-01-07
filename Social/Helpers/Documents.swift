//
//  Documents.swift
//  Social
//
//  Created by Aybars Acar on 7/1/2022.
//

import Foundation


/// Fields within the User Document in Database
/// these are the field names / keys
struct DatabaseUserField {
  
  private init() { }
  
  static let displayName = "display_name"
  static let email = "email"
  static let providerID = "provider_id"
  static let provider = "provider"
  static let userID = "user_id"
  static let bio = "bio"
  static let createdAt = "created_at"
  
}


/// kets for the UserDefaults saved within app
struct CurrentUserDefaultsKeys {
  
  private init() { }
  
  static let displayName = "display_name"
  static let userID = "user_id"
  static let bio = "bio"
  
}


/// Fields within the Post Document in Database
/// these are the field names / keys
struct DatabasePostField {
  
  private init() { }
  
  static let postID = "post_id"
  static let userID = "user_id"
  static let displayName = "display_name"
  static let caption = "caption"
  static let createdAt = "created_at"
  
  static let likeCount = "like_count" // INT
  static let likedBy = "liked_by" // String[]
}
