//
//  MessageView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct MessageView: View {
  
  @State var comment: Comment
  @State private var profileImage: UIImage = UIImage(named: "logo.loading")!
  
  
  var body: some View {
    HStack {
      
      NavigationLink(destination: LazyView(content: {
        ProfileView(profileDisplayName: comment.username, profileUserID: comment.userID, isMyProfile: false, posts: PostArrayObject(userID: comment.userID))
      })) {
        
        Image(uiImage: profileImage)
          .resizable()
          .scaledToFill()
          .frame(width: 40, height: 40, alignment: .center)
          .cornerRadius(40)
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text(comment.username)
          .font(.caption)
          .foregroundColor(.secondary)
        
        Text(comment.content)
          .padding(10)
          .foregroundColor(.white)
          .background(.secondary)
          .cornerRadius(10)
      }
      
      // to push all the way to the lef
      Spacer(minLength: 0)
    }
    .onAppear {
      getProfileImage()
    }
  }
}


extension MessageView {
  
  private func getProfileImage() {
    ImageManager.shared.downloadProfileImage(userID: comment.userID) { image in
      if let image = image {
        profileImage = image
      }
    }
  }
}


struct MessageView_Previews: PreviewProvider {
  
  static var comment: Comment = Comment(commentID: "", userID: "", username: "Aybars Acar", content: "This is my comment I have created for preview!", createdAt: Date())
  
  static var previews: some View {
    Group {
      MessageView(comment: comment)
        .previewLayout(.sizeThatFits)
      
      MessageView(comment: comment)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
  }
}
