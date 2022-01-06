//
//  PostArrayObject.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import Foundation


/// this is like our view model
class PostArrayObject: ObservableObject {
  
  @Published var dataArray: [Post] = []
  
  
  init() {
    let post1 = Post(postID: "", userID: "", username: "Aybars Acar", caption: "This is a test caption",createdAt: Date(), likeCount: 0, isLikedByUser: false)
    let post2 = Post(postID: "", userID: "", username: "Jessica", caption: nil,createdAt: Date(), likeCount: 204, isLikedByUser: true)
    let post3 = Post(postID: "", userID: "", username: "Emily", caption: "This is a test caption which is very long hahahaha. :)",createdAt: Date(), likeCount: 10, isLikedByUser: true)
    let post4 = Post(postID: "", userID: "", username: "Christopher", caption: nil,createdAt: Date(), likeCount: 4, isLikedByUser: false)
    
    dataArray.append(post1)
    dataArray.append(post2)
    dataArray.append(post3)
    dataArray.append(post4)
  }
  
  /// used for single post selection
  init(post: Post) {
    dataArray.append(post)
  }
}
