//
//  AuthService.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import Foundation
import FirebaseAuth
import UIKit
import FirebaseFirestore


let DATABASE = Firestore.firestore()


/// used to authenticate users in Firebase
/// used to handle user accounts in Firebase
class AuthService {
  
  static let shared = AuthService()
  private init() { }
  
  // users collection
  private var REF_USERS = DATABASE.collection("users")
  
  
  /// Sign them into  Firebase Auth..
  func loginUserToFirebase(credential: AuthCredential, handler: @escaping (_ providerID: String?, _ isError: Bool, _ errorMessage: String?) -> Void) {
    
    Auth.auth().signIn(with: credential) { result, error in
      
      if let error = error {
        print(error.localizedDescription)
        
        handler(nil, true, error.localizedDescription)
        return
      }
      
      // Displaying username
      guard let providerID = result?.user.uid else {
        
        handler(nil, true, "Error getting the providcer ID")
        return
      }
      
      // success connecting to Firebase Auth
      handler(providerID, false, nil)
    }
  }
  
  
  /// creates the user information and saves it into the database
  func createNewUserInDatabase(name: String, email: String, providerID: String, provider: String, profileImage: UIImage, handler: @escaping (_ userID: String?) -> Void) {
    
    // setup a user document in the user collection
    let document = REF_USERS.document()
    let userID = document.documentID

    // upload profile image to storage
    ImageManager.shared.uploadProfileImage(userID: userID, image: profileImage)
    
    // upload profile data to Firestore
    let userData: [String: Any] = [
      DatabaseUserField.displayName: name,
      DatabaseUserField.email: email,
      DatabaseUserField.providerID: providerID,
      DatabaseUserField.provider: provider,
      DatabaseUserField.userID: userID,
      DatabaseUserField.bio: "",
      DatabaseUserField.createdAt: FieldValue.serverTimestamp() // time of now
    ]
    
    document.setData(userData) { error in
      
      if let error = error {
        print("error uploading data using document", error.localizedDescription)
        handler(nil)
      } else {
        
        handler(userID)
      }
    }
  }
  
  
  /// connect the user into the UI of the app
  /// log them in the device
  func loginUserToApp(userID: String, handler: @escaping (_ success: Bool) -> Void) {
    // get the users info
    getUserInfo(userID: userID) { name, bio in
      
      guard let name = name, let bio = bio else {
        print("Error getting user info while logging in")
        handler(false)
        return
      }
      
      // success
      handler(true)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        // set the user's info in our app - in the UserDefaults
        UserDefaults.standard.set(userID, forKey: CurrentUserDefaultsKeys.userID)
        UserDefaults.standard.set(bio, forKey: CurrentUserDefaultsKeys.bio)
        UserDefaults.standard.set(name, forKey: CurrentUserDefaultsKeys.displayName)
      }
    }
  }
  
  
  func getUserInfo(userID: String, handler: @escaping (_ name: String?, _ bio: String?) -> Void) {
    
    // becuase we save the documentID as userID
    REF_USERS.document(userID).getDocument { documentSnapshot, error in
      
      if let document = documentSnapshot,
         let name = document.get(DatabaseUserField.displayName) as? String,
         let bio = document.get(DatabaseUserField.bio) as? String {
        
        handler(name, bio)
        return
      }
      
      // we have an error
      print("error getting user info")
      handler(nil, nil)
    }
  }
}
