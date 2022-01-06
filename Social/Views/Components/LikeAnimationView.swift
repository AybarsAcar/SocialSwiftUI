//
//  LikeAnimationView.swift
//  Social
//
//  Created by Aybars Acar on 6/1/2022.
//

import SwiftUI


struct LikeAnimationView: View {
  
  enum HeartSize: Double {
    case normal = 1.0
    
    case huge = 1.5
    case large = 1.25
    case medium = 0.75
    case small = 0.5
    case tiny = 0.25
  }
  
  @Binding var animate: Bool
  @State var size: HeartSize = .normal
  
  
  var body: some View {
    ZStack {
      Image(systemName: "heart.fill")
        .foregroundColor(.red.opacity(0.3))
        .font(.system(size: 200 * size.rawValue))
        .opacity(animate ? 1.0 : 0.0)
        .scaleEffect(animate ? 1.0 : 0.3)
      
      Image(systemName: "heart.fill")
        .foregroundColor(.red.opacity(0.6))
        .font(.system(size: 150 * size.rawValue))
        .opacity(animate ? 1.0 : 0.0)
        .scaleEffect(animate ? 1.0 : 0.4)
      
      Image(systemName: "heart.fill")
        .foregroundColor(.red.opacity(0.9))
        .font(.system(size: 100 * size.rawValue))
        .opacity(animate ? 1.0 : 0.0)
        .scaleEffect(animate ? 1.0 : 0.8)
    }
  }
}



struct LikeAnimationView_Previews: PreviewProvider {
  static var previews: some View {
    LikeAnimationView(animate: .constant(false))
      .previewLayout(.sizeThatFits)
  }
}
