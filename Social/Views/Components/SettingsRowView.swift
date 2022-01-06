//
//  SettingsRowView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct SettingsRowView: View {
  
  let icon: String
  let text: String
  let color: Color
  
  
  var body: some View {
    HStack {
    
      ZStack {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
          .fill(color)
        
        Image(systemName: icon)
          .font(.title3)
          .foregroundColor(.white)
      }
      .frame(width: 36, height: 36)
    
      Text(text)
      
      Spacer()
      
      Image(systemName: "chevron.right")
        .font(.headline)
    }
    .padding(.vertical, 4)
    .foregroundColor(.primary)
  }
}



struct SettingsRowView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsRowView(icon: "heart.fill", text: "Row Title", color: .blue)
      .previewLayout(.sizeThatFits)
  }
}
