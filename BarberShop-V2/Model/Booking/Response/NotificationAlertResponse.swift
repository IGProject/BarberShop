//
//  NotificationAlertResponse.swift
//  BarberShop-V2
//
//  Created by User on 12/24/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct NotificationAlertResponse: Codable {
  let count: Int
  let results: [Result]
}

struct Result: Codable {
  let id: Int
  let title, body: String
  let status: Bool
  let type: String
  let createdAt: String
  let actionTeamBy: ActionTeamBy
  
  enum CodingKeys: String, CodingKey {
    case id, title, body, status, type
    case createdAt = "created_at"
    case actionTeamBy
  }
}

struct ActionTeamBy: Codable {
  let id: Int
  let username, teamProfile: String
  
  enum CodingKeys: String, CodingKey {
    case id, username
    case teamProfile = "team_profile"
}
}
