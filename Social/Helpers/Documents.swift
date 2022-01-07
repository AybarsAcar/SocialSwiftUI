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
