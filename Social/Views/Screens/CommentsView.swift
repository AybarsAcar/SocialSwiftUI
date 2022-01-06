//
//  CommentsView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct CommentsView: View {
  
  // get access to the device's default color scheme
  @Environment(\.colorScheme) private var colorScheme
  
  @State private var text: String = ""
  
  @State var comments: [Comment] = []
  
  
  var body: some View {
    VStack {
      ScrollView {
        LazyVStack {
          ForEach(comments) { comment in
            MessageView(comment: comment)
          }
        }
      }
      
      HStack {
        Image("dog1")
          .resizable()
          .scaledToFill()
          .frame(width: 40, height: 40)
          .cornerRadius(40)
        
        TextField("Add a comment here...", text: $text)
        
        Button(action: {}) {
          Image(systemName: "paperplane.fill")
            .font(.title2)
        }
        .tint(colorScheme == .light ? .theme.purple : .theme.yellow)
      }
      .padding(6)
    }
    .navigationTitle("Comments")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      // load the comments
      getComments()
    }
  }
}


extension CommentsView {
  
  func getComments() {
    let comment1 = Comment(commentID: "", userID: "", username: "Aybars", content: "This is a commment", createdAt: Date())
    let comment2 = Comment(commentID: "", userID: "", username: "Jake", content: "This is the second commment", createdAt: Date())
    let comment3 = Comment(commentID: "", userID: "", username: "Aybars", content: "This is the third commment", createdAt: Date())
    let comment4 = Comment(commentID: "", userID: "", username: "Jessica", content: "This is the fourth commment", createdAt: Date())
    
    self.comments.append(comment1)
    self.comments.append(comment2)
    self.comments.append(comment3)
    self.comments.append(comment4)
  }
  
}



struct CommentsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CommentsView()
    }
  }
}
