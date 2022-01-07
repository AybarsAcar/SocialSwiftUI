//
//  ContentView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct ContentView: View {
  
  // get access to the device's default color scheme
  @Environment(\.colorScheme) private var colorScheme
  
  // access the UserDefaults value
  @AppStorage(CurrentUserDefaultsKeys.userID) private var currentUserID: String?
  @AppStorage(CurrentUserDefaultsKeys.displayName) private var currentUserDisplayName: String?
  
  let feedPosts = PostArrayObject(shuffled: false)
  let browsePosts = PostArrayObject(shuffled: true)
  
  var body: some View {
    
    TabView {
      NavigationView {
        FeedView(posts: feedPosts, title: "Feed")
      }
      .tabItem {
        Image(systemName: "book.fill")
        Text("Feed")
      }
      
      NavigationView {
        BrowseView(posts: browsePosts)
      }
      .tabItem {
        Image(systemName: "magnifyingglass")
        Text("Browse")
        
      }
      
      UploadView()
        .tabItem {
          Image(systemName: "square.and.arrow.up.fill")
          Text("Upload")
        }
      
      ZStack {
        
        if let userID = currentUserID, let displayName = currentUserDisplayName {
          NavigationView{
            ProfileView(profileDisplayName: displayName, profileUserID: userID, isMyProfile: true, posts: PostArrayObject(userID: userID))
          }
        } else {
          SignUpView()
        }
        
      }
      .tabItem {
        Image(systemName: "person.fill")
        Text("Profile")
      }
    }
    .accentColor(colorScheme == .light ? .theme.purple : .theme.yellow)
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
