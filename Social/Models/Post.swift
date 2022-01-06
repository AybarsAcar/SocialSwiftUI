//
//  Post.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import Foundation
import SwiftUI


struct Post: Identifiable, Hashable {
  
  var id: UUID = UUID()
  
  var postID: String // ID for hte post in database
  var userID: String // ID for the user in Database
  var username: String
  var caption: String?
  var createdAt: Date // date the post is created at
  var likeCount: Int
  var isLikedByUser: Bool // whether the current user liked the post or not
  
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
}
