//
//  CommentsView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct CommentsView: View {
  
  let post: Post
  
  // get access to the device's default color scheme
  @Environment(\.colorScheme) private var colorScheme
  
  @AppStorage(CurrentUserDefaultsKeys.userID) private var currentUserID: String?
  @AppStorage(CurrentUserDefaultsKeys.displayName) private var currentUserDisplayName: String?
  
  @State private var text: String = ""
  @State var comments: [Comment] = []
  
  @State private var profilePicture: UIImage = UIImage(named: "logo.loading")!
  
  
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
        Image(uiImage: profilePicture)
          .resizable()
          .scaledToFill()
          .frame(width: 40, height: 40)
          .cornerRadius(40)
        
        TextField("Add a comment here...", text: $text)
        
        Button(action: {
          if isTextAppropriate() {
            addComment()
          }
        }) {
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
      getProfilePicture()
    }
  }
}


extension CommentsView {
  
  func getProfilePicture() {
    
    guard let userID = currentUserID else { return }
    
    ImageManager.shared.downloadProfileImage(userID: userID) { image in
      if let image = image {
        self.profilePicture = image
      }
    }
  }
  
  
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
  
  
  private func addComment() {
    guard let userID = currentUserID, let displayName = currentUserDisplayName else { return }
    
    // trim the whitespaces
    let trimmedText = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // upload to the database
    DataService.shared.uploadComment(postID: post.postID, content: trimmedText, displayName: displayName, userID: userID) { success, commentID in
      
      if success, let commentID = commentID {
        let newComment = Comment(commentID: commentID, userID: userID, username: displayName, content: trimmedText, createdAt: Date())
        
        self.comments.append(newComment)
        
        // clear the text in the text field
        self.text = ""
        
        // dismiss the keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
    }
  }
  
  
  func isTextAppropriate() -> Bool {
    let badWordArray: [String] = ["shit", "ass"]
    
    let words = text.components(separatedBy: " ")
    
    for word in words {
      if badWordArray.contains(word) {
        return false
      }
    }
    
    // check for length
    if text.count < 4 {
      return false
    }
    
    return true
  }
}



struct CommentsView_Previews: PreviewProvider {
  
  static var previews: some View {
    NavigationView {
      CommentsView(post: Post(postID: "", userID: "", username: "Username", createdAt: Date(), likeCount: 1, isLikedByUser: false))
    }
  }
}
