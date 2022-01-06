//
//  CarouselView.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI


struct CarouselView: View {
  
  private let maxCount: Int = 8
  
  @State private var selection: Int = 1
  
  @State private var timerAdded: Bool = false
  
  
  var body: some View {
    TabView(selection: $selection) {
      
      ForEach(1 ..< maxCount) { i in
        Image("dog\(i)")
          .resizable()
          .scaledToFill()
          .tag(i)
      }
      
    }
    .tabViewStyle(.page)
    .frame(height: 300)
    .onAppear {
      if !timerAdded {
        addTimer()
      }
    }
  }
}


extension CarouselView {
  
  private func addTimer() {
    timerAdded = true
    
    let timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { timer in
      
      // change the selection every n seconds
      withAnimation(.easeIn(duration: 0.5)) {
        if selection == maxCount - 1 {
          selection = 1
        } else {
          selection += 1
        }
      }
    }
  
    timer.fire()
  }
  
}


struct CarouselView_Previews: PreviewProvider {
  static var previews: some View {
    CarouselView()
      .previewLayout(.sizeThatFits)
  }
}
