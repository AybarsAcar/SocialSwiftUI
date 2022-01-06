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
  
  var currentUserID: String? = nil
  
  
  var body: some View {
    
    TabView {
      NavigationView {
        FeedView(posts: PostArrayObject(), title: "Feed")
      }
      .tabItem {
        Image(systemName: "book.fill")
        Text("Feed")
      }
      
      NavigationView {
        BrowseView()
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
        
        if currentUserID != nil {
          NavigationView{
            ProfileView(profileDisplayName: "Aybars Acar", profileUserID: "", isMyProfile: true)
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
