//
//  ImageGridView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct ImageGridView: View {
  
  @ObservedObject var posts: PostArrayObject
  
  
  var body: some View {
    
    LazyVGrid(
      columns: [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
      ],
      alignment: .center,
      spacing: nil,
      pinnedViews: []
    ) {
      ForEach(posts.dataArray) { post in
        NavigationLink(destination: FeedView(posts: PostArrayObject(post: post), title: post.username)) {
          PostView(post: post, showHeaderAndFooter: false, addHeartAnimationToView: false)
        }
      }
    }
  }
}



struct ImageGridView_Previews: PreviewProvider {
  static var previews: some View {
    ImageGridView(posts: PostArrayObject())
      .previewLayout(.sizeThatFits)
  }
}
