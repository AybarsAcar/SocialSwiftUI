//
//  FeedView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct FeedView: View {
  
  @ObservedObject var posts: PostArrayObject
  let title: String
  
  
  var body: some View {
  
    ScrollView(.vertical, showsIndicators: false) {
      
      LazyVStack {
        ForEach(posts.dataArray) { post in
          PostView(post: post, showHeaderAndFooter: true, addHeartAnimationToView: true)
        }
      }
      
    }
    .navigationTitle(title.capitalized)
    .navigationBarTitleDisplayMode(.inline)
  }
}



struct FeedView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FeedView(posts: PostArrayObject(), title: "Feed View")
    }
  }
}
