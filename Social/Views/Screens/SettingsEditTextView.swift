//
//  SettingsEditTextView.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import SwiftUI


struct SettingsEditTextView: View {
  
  @Environment(\.colorScheme) private var colorScheme

  let title: String
  let description: String
  let placeholder: String
  
  @State var text: String = ""
  
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
      
      Button(action: {}) {
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
  }
}



struct SettingsEditTextView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SettingsEditTextView(title: "Test title", description: "This is a test description", placeholder: "Test placeholder")
    }
  }
}
