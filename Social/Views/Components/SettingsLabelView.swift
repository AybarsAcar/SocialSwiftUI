//
//  SettingsLabelView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct SettingsLabelView: View {
  
  let title: String
  let image: String
  
  var body: some View {
    VStack {
      HStack {
        Text(title)
          .fontWeight(.bold)
        
        Spacer()
        
        Image(systemName: image)
      }
      
      Divider()
        .padding(.vertical, 4)
    }
  }
}



struct SettingsLabelView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsLabelView(title: "Label Title", image: "heart")
      .previewLayout(.sizeThatFits)
  }
}
