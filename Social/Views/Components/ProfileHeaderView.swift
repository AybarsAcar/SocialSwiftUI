//
//  ProfileHeaderView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct ProfileHeaderView: View {
  
  @Binding var profileDisplayName: String
  @Binding var profileImage: UIImage
  
  var body: some View {
    
    VStack(alignment: .center, spacing: 10) {
      
      Image(uiImage: profileImage)
        .resizable()
        .scaledToFill()
        .frame(width: 120, height: 120)
        .cornerRadius(120)
      
      Text(profileDisplayName)
        .font(.largeTitle)
        .fontWeight(.semibold)
      
      Text("This is user bio")
        .font(.body)
        .fontWeight(.regular)
        .multilineTextAlignment(.center)
      
      HStack(alignment: .center, spacing: 20) {
        
        VStack(alignment: .center, spacing: 5) {
          Text("5")
            .font(.title2)
            .fontWeight(.bold)
          
          Capsule()
            .fill(Color.secondary)
            .frame(width: 20, height: 2)
          
          Text("Posts")
            .font(.footnote)
        }
        
        VStack(alignment: .center, spacing: 5) {
          Text("20")
            .font(.title2)
            .fontWeight(.bold)
          
          Capsule()
            .fill(Color.secondary)
            .frame(width: 20, height: 2)
          
          Text("Likes")
            .font(.footnote)
        }
      }
    }
    .frame(maxWidth: .infinity)
    .padding()
  }
}



struct ProfileHeaderView_Previews: PreviewProvider {
  
  @State static var name: String = "Aybars Acar"
  
  static var previews: some View {
    Group {
      ProfileHeaderView(profileDisplayName: $name, profileImage: .constant(UIImage(named: "dog1")!))
        .previewLayout(.sizeThatFits)
      
      ProfileHeaderView(profileDisplayName: $name, profileImage: .constant(UIImage(named: "dog1")!))
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
  }
}
