//
//  AnalyticsService.swift
//  Social
//
//  Created by Aybars Acar on 8/1/2022.
//

import Foundation
import FirebaseAnalytics


class AnalyticsService {
  
  static let shared = AnalyticsService()
  private init() { }
  
  
  /// track how many times users choose to like the post by double tapping on the image
  func likePostDoubleTapOnImage() {
    
    // parameters are nil but we can pass other information like postID, userID, time, etc
    Analytics.logEvent("like_double_tap_on_image", parameters: nil)
  }
  
  
  /// track how many times users choose to like the post by tapping on the heart button
  func likePostHeartPressed() {
    Analytics.logEvent("like_heart_button_tapped", parameters: nil)
  }
}
