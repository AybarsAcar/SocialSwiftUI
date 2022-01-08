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
  @Published var postCountAsString: String = "0" // so the view keeps watching
  @Published var likeCountAsString: String = "0"
  
  
#if DEBUG
  /// test init for default sample posts
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
#endif
  
  /// used for single post selection
  init(post: Post) {
    dataArray.append(post)
  }
  
  
  /// used for getting posts for user profile
  /// fetches the posts posted by the user id passed in
  init(userID: String) {
    DataService.shared.downloadPostsForUser(userID: userID) { posts in
      
      let sortedPosts = posts.sorted { p1, p2 in
        return p1.createdAt > p2.createdAt
      }
      
      self.dataArray.append(contentsOf: sortedPosts)
      self.updateCounts()
    }
  }
  
  
  /// used for feed
  /// returns all the posts in the database
  init(shuffled: Bool) {
    DataService.shared.downloadPostsForFeed { posts in
      
      if shuffled {
        let shuffledPosts = posts.shuffled()
        self.dataArray.append(contentsOf: shuffledPosts)
      } else {
        self.dataArray.append(contentsOf: posts)
      }
    }
  }
  
  
  private func updateCounts() {
    
    // update post count
    self.postCountAsString = "\(self.dataArray.count)"
    
    // update like count
    let likeCountArray = dataArray.map { (post) -> Int in
      return post.likeCount
    }
    let likeCount = likeCountArray.reduce(0, +)
    self.likeCountAsString = "\(likeCount)"
  }
}
