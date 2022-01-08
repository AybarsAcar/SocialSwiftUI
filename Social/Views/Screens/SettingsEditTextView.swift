//
//  SettingsEditTextView.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import SwiftUI


struct SettingsEditTextView: View {
  
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.presentationMode) private var presentationMode
  @AppStorage(CurrentUserDefaultsKeys.userID) private var currentUserID: String?

  let title: String
  let description: String
  let placeholder: String
  let option: SettingsEditTextOption
  
  @Binding var profileText: String
  
  @State var text: String = ""
  
  
  @State private var showSuccess: Bool = false
  
  
  private let haptics = UINotificationFeedbackGenerator()
  
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(description)
        .multilineTextAlignment(.leading)
      
      TextField(placeholder, text: $text)
        .padding()
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .light ? Color.theme.beige : Color.theme.purple)
        .font(.headline)
        .cornerRadius(12)
        .autocapitalization(.sentences)
      
      Button(action: {
        if isTextAppropriate() {
          saveText()
        }
      }) {
        Text("save".uppercased())
          .font(.title3)
          .fontWeight(.bold)
          .padding()
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          .background(colorScheme == .light ? Color.theme.purple : Color.theme.yellow)
          .cornerRadius(12)
      }
      .accentColor(colorScheme == .light ? .theme.yellow : .theme.purple)
      
      Spacer()
    }
    .padding()
    .frame(maxWidth: .infinity)
    .navigationTitle(title)
    .alert(isPresented: $showSuccess) {
      return Alert(title: Text("Successfully updated"), message: nil, dismissButton: .default(Text("Ok"), action: {
        dismissView()
      }))
    }
  }
}


extension SettingsEditTextView {
  
  enum SettingsEditTextOption {
    case displayName, bio
  }
  
  private func dismissView() {
    
    haptics.notificationOccurred(.success)
    
    // dismiss the current view and go back to the previous view (settings view)
    presentationMode.wrappedValue.dismiss()
  }
  
  private func saveText() {
    
    guard let userID = currentUserID else { return }
    
    switch option {
    case .displayName:
      // update the ui on the profile
      self.profileText = self.text
      
      // update the user defaults
      UserDefaults.standard.set(text, forKey: CurrentUserDefaultsKeys.displayName)
      
      // update on all of the users posts
      DataService.shared.updateDisplayNameOnPosts(userID: userID, newDisplayName: self.text)
      
      // update on the user's profile in the database
      AuthService.shared.updateUserDisplayName(userID: userID, newDisplayName: self.text) { success in
        if success {
          self.showSuccess.toggle()
        }
      }
      
    case .bio:
      // update the ui on the profile
      self.profileText = self.text
      
      // update the user defaults
      UserDefaults.standard.set(text, forKey: CurrentUserDefaultsKeys.bio)
      
      // update on the user's profile in the database
      AuthService.shared.updateUserBio(userID: userID, newBio: self.text) { success in
        if success {
          self.showSuccess.toggle()
        }
      }
    }
  }
  
  private func isTextAppropriate() -> Bool {
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


struct SettingsEditTextView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SettingsEditTextView(title: "Test title", description: "This is a test description", placeholder: "Test placeholder", option: .displayName, profileText: .constant("This is text"))
    }
  }
}
