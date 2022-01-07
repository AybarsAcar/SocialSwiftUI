//
//  BrowseView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct BrowseView: View {
  
  var posts: PostArrayObject
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      CarouselView()
      
      ImageGridView(posts: posts)
    }
    .navigationTitle("Browse")
    .navigationBarTitleDisplayMode(.inline)
  }
}



struct BrowseView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BrowseView(posts: PostArrayObject())
    }
  }
}
