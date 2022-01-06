//
//  Comment.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import Foundation
import SwiftUI


struct Comment: Identifiable, Hashable {
  
  var id: UUID = UUID()
  
  var commentID: String // ID for the comment in the db
  var userID: String // ID for the user who created the comment in the db
  var username: String // creator of the comment
  var content: String
  var createdAt: Date
  
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
