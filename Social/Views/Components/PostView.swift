//
//  PostView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct PostView: View {
  
  @State var post: Post
  let showHeaderAndFooter: Bool
  let addHeartAnimationToView: Bool
  
  @State private var animateLike: Bool = false
  
  @State private var showActionSheet: Bool = false
  @State private var actionSheetType: PostActionSheetOption = .general
  
  @State private var postImage: UIImage = UIImage(named: "dog1")!
  
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      
      if showHeaderAndFooter {
        HStack {
          // MARK: HEADER
          NavigationLink(destination: ProfileView(profileDisplayName: post.username, profileUserID: post.userID, isMyProfile: false)) {
            
            Image("dog1")
              .resizable()
              .scaledToFill()
              .frame(width: 30, height: 30)
              .cornerRadius(30)
            
            Text(post.username)
              .font(.callout)
              .fontWeight(.medium)
              .foregroundColor(.primary)
          }
          
          Spacer()
          
          Image(systemName: "ellipsis")
            .font(.headline)
            .rotationEffect(Angle(degrees: 90))
            .onTapGesture {
              showActionSheet.toggle()
            }
            .actionSheet(isPresented: $showActionSheet) {
              getActionSheet()
            }
        }
        .padding(6)
      }
      
      // MARK: IMAGE
      ZStack {
        Image(uiImage: postImage)
          .resizable()
          .scaledToFit()
          .onTapGesture(count: 2) {
            likePost()
          }
        
        if addHeartAnimationToView {
          LikeAnimationView(animate: $animateLike, size: .huge)
        }
      }
      
      if showHeaderAndFooter {
        // MARK: FOOTER
        HStack(alignment: .center, spacing: 20) {
          
          Image(systemName: post.isLikedByUser ? "heart.fill" : "heart")
            .font(.title3)
            .foregroundColor(post.isLikedByUser ? .red : .primary)
            .onTapGesture {
              if post.isLikedByUser {
                // user is unliking the post
                unlikePost()
              } else {
                // user is liking the post
                likePost()
              }
            }
          
          NavigationLink(destination: CommentsView()) {
            Image(systemName: "bubble.middle.bottom")
              .font(.title3)
              .foregroundColor(.primary)
          }
          
          Image(systemName: "paperplane")
            .font(.title3)
            .onTapGesture {
              sharePost()
            }
          
        }
        .padding(6)
        
        if let caption = post.caption {
          Text(caption)
            .padding(6)
        }
      }
    }
  }
}


extension PostView {
  
  enum PostActionSheetOption {
    case general
    case reporting
  }
  
  private func likePost() {
    
    // update local data
    let updatedPost = Post(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, createdAt: post.createdAt, likeCount: post.likeCount + 1, isLikedByUser: true)
    
    self.post = updatedPost
    
    withAnimation(.easeInOut(duration: 0.5)){
      animateLike = true
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
      withAnimation(.easeInOut(duration: 0.5)){
        animateLike = false
      }
    }
  }
  
  
  private func unlikePost() {
    // update local data
    let updatedPost = Post(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, createdAt: post.createdAt, likeCount: post.likeCount - 1, isLikedByUser: false)
    
    self.post = updatedPost
  }
  
  
  private func getActionSheet() -> ActionSheet {
    
    switch actionSheetType {
    case .general:
      return ActionSheet(title: Text("What would you like to do?"), message: nil, buttons: [
        .destructive(Text("Report"), action: {
          self.actionSheetType = .reporting
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showActionSheet.toggle()
          }
        }),
        .default(Text("Learn more..."), action: {
          print("Learn more pressed")
        }),
        .cancel()
      ])
      
    case .reporting:
      return ActionSheet(title: Text("Why are you reporting this post?"), message: nil, buttons: [
        .destructive(Text("This is inappropriate"), action: {
          reportPost(reason: "This is inappropriate")
        }),
        .destructive(Text("This is spam"), action: {
          reportPost(reason: "This is spam")
        }),
        .destructive(Text("It made me uncomfortable"), action: {
          reportPost(reason: "It made me uncomfortable")
        }),
        .cancel({
          self.actionSheetType = .general
        })
      ])
    }
    
  }
  
  
  private func reportPost(reason: String) {
    
  }
  
  
  /// enable deep links when sharing the post
  private func sharePost() {
    
    let message = "Check out this post on DogGram"
    let image = postImage
    
    // this should be a deep link back to your app
    let link = URL(string: "https://google.com")!
    
    let activityViewController = UIActivityViewController(activityItems: [message, image, link], applicationActivities: nil)
    
    // get access to the background view controller
    let viewController = UIApplication.shared.windows.first?.rootViewController
    
    viewController?.present(activityViewController, animated: true, completion: nil)
  }
}


struct PostView_Previews: PreviewProvider {
  
  static var post: Post = Post(postID: "", userID: "", username: "Aybars Acar", caption: "This is a test caption",createdAt: Date(), likeCount: 0, isLikedByUser: false)
  
  static var previews: some View {
    Group {
      PostView(post: post, showHeaderAndFooter: true, addHeartAnimationToView: true)
        .previewLayout(.sizeThatFits)
      
      PostView(post: post, showHeaderAndFooter: false, addHeartAnimationToView: true)
        .previewLayout(.sizeThatFits)
    }
  }
}
