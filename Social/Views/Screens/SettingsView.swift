//
//  SettingsView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct SettingsView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  @Environment(\.colorScheme) private var colorScheme
  
  @Binding var userDisplayName: String
  @Binding var userBio: String
  @Binding var userProfilePicture: UIImage
  
  @State private var showError: Bool = false
  
  
  var body: some View {
    
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        
        GroupBox {
          HStack(alignment: .center, spacing: 10) {
            
            Image("logo")
              .resizable()
              .scaledToFit()
              .frame(width: 80, height: 80)
              .cornerRadius(12)
            
            Text("DogGram is the #1 app for posting pictures of your dog and sharing them across the world. We are a dog-loving community and we're happy to weldome you")
              .font(.footnote)
          }
          
        } label: {
          SettingsLabelView(title: "DogGram", image: "dot.radiowaves.left.and.right")
        }
        .padding()
        
        GroupBox {
          VStack {
            NavigationLink(
              destination: SettingsEditTextView(
                title: "Display Name",
                description: "You can edit your display name here. This will be seen by other users on your profile and on your posts.",
                placeholder: "Your display name here...",
                option: .displayName,
                profileText: $userDisplayName,
                text: userDisplayName
              )
            ) {
              SettingsRowView(icon: "pencil", text: "Display Name", color: .theme.purple)
            }
            
            NavigationLink(
              destination: SettingsEditTextView(
                title: "Profile Bio",
                description: "Your bio is a gread place to let other users know a little about you. It will be shown on your profile only",
                placeholder: "Your bio here...",
                option: .bio,
                profileText: $userBio,
                text: userBio
              )
            ) {
              SettingsRowView(icon: "text.quote", text: "Bio", color: .theme.purple)
            }
            
            NavigationLink(
              destination: SettingsEditImageView(
                title: "Profile Picture",
                description: "Your profile picture will be shown on your profile and on your posts. Most users make it an image of themselves or of their dog",
                selectedImage: userProfilePicture,
                profileImage: $userProfilePicture
              )
            ) {
              SettingsRowView(icon: "photo", text: "Profile Picture", color: .theme.purple)
            }
            
            Button(action: {
              signOut()
            }) {
              SettingsRowView(icon: "figure.walk", text: "Sign out", color: .theme.purple)
            }
            .alert("Error logging out", isPresented: $showError) {
              
            }
          }
          
        } label: {
          SettingsLabelView(title: "Profile", image: "person.fill")
        }
        .padding()
        
        GroupBox {
          VStack {
            
            Link(destination: URL(string: "https://google.com")!) {
              SettingsRowView(icon: "folder.fill", text: "Privacy Policy", color: .theme.yellow)
            }
            
            Link(destination: URL(string: "https://google.com")!) {
              SettingsRowView(icon: "folder.fill", text: "Terms and Conditions", color: .theme.yellow)
            }
            
            Link(destination: URL(string: "https://google.com")!) {
              SettingsRowView(icon: "globe", text: "DogGram's Website", color: .theme.yellow)
            }
          }
          
        } label: {
          SettingsLabelView(title: "Application", image: "apps.iphone")
        }
        .padding()
        
        
        GroupBox {
          Text("DogGram was made with love.\nAll Rights Reserved\nAybars Acar Inc.\nCopyright 2022")
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .padding(.bottom, 80)
      }
      .navigationTitle("Settings")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            presentationMode.wrappedValue.dismiss()
          }) {
            Image(systemName: "xmark")
          }
          .accentColor(.primary)
        }
      }
    }
    .accentColor(colorScheme == .light ? .theme.purple : .theme.yellow)
  }
}


extension SettingsView {
  
  func signOut() {
    AuthService.shared.logoutUser { success in
      if success {
        // dismiss the settings view
        self.presentationMode.wrappedValue.dismiss()
        
      } else {
        print ("error logging out")
        
        self.showError.toggle()
      }
    }
  }
}



struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(userDisplayName: .constant("Aybars Acar"), userBio: .constant("Bio goes here"), userProfilePicture: .constant(UIImage(named: "dog1")!))
  }
}
