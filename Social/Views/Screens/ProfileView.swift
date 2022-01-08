//
//  ProfileView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct ProfileView: View {
  
  @Environment(\.colorScheme) private var colorScheme
  
  @State var profileDisplayName: String
  let profileUserID: String
  let isMyProfile: Bool
  var posts: PostArrayObject
  
  @State private var profileBio: String = ""
  
  @State private var profileImage: UIImage = UIImage(named: "logo.loading")!
  
  @State private var isSettingsDisplayed: Bool = false
  
  
  var body: some View {
    
    ScrollView(.vertical, showsIndicators: false) {
      ProfileHeaderView(profileDisplayName: $profileDisplayName, profileBio: $profileBio, profileImage: $profileImage, postArray: self.posts)
      
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
    .onAppear(perform: {
      getProfileImage()
      getAdditionalProfileInfo()
    })
    .sheet(isPresented: $isSettingsDisplayed, onDismiss: {
      isSettingsDisplayed = false
    }) {
      SettingsView(userDisplayName: $profileDisplayName, userBio: $profileBio, userProfilePicture: $profileImage)
    }
  }
}


extension ProfileView {
  
  func getProfileImage() {
    ImageManager.shared.downloadProfileImage(userID: profileUserID) { image in
      if let image = image {
        profileImage = image
      }
    }
  }
  
  func getAdditionalProfileInfo() {
    AuthService.shared.getUserInfo(userID: profileUserID) { name, bio in
      if let name = name {
        self.profileDisplayName = name
      }
      
      if let bio = bio {
        self.profileBio = bio
      }
    }
  }
}


struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ProfileView(profileDisplayName: "Aybars Acar", profileUserID: "", isMyProfile: true, posts: PostArrayObject())
    }
  }
}
