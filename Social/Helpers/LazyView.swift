//
//  LazyView.swift
//  Social
//
//  Created by Aybars Acar on 7/1/2022.
//

import Foundation
import SwiftUI


/// wrapper struct for lazy navigation
/// so the navigation link creates teh lazy view but not the content it wraps
/// the data for wrapped content is only created when navigated to
struct LazyView<Content: View>: View {
  
  var content: () -> Content
  
  var body: some View {
    content()
  }
  
}
