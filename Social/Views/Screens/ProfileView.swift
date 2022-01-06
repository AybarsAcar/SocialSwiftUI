//
//  ProfileView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct ProfileView: View {
  
  @Environment(\.colorScheme) private var colorScheme

  
  var posts = PostArrayObject()
  
  @State var profileDisplayName: String
  let profileUserID: String
  let isMyProfile: Bool
  
  @State private var isSettingsDisplayed: Bool = false
  
  
  var body: some View {
    
    ScrollView(.vertical, showsIndicators: false) {
      ProfileHeaderView(profileDisplayName: $profileDisplayName)
      
      Divider()
        .frame(width: UIScreen.main.bounds.width * 0.6 )
      
      ImageGridView(posts: posts)
    }
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          isSettingsDisplayed.toggle()
        }) {
          Image(systemName: "line.horizontal.3")
        }
        .accentColor(colorScheme == .light ? .theme.purple : .theme.yellow)
        .opacity(isMyProfile ? 1.0 : 0.0)
      }
    }
    .sheet(isPresented: $isSettingsDisplayed, onDismiss: {
      isSettingsDisplayed = false
    }) {
      SettingsView()
    }
  }
}



struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ProfileView(profileDisplayName: "Aybars Acar", profileUserID: "", isMyProfile: true)
    }
  }
}
