//
//  BookingResponse.swift
//  BarberShop-V2
//
//  Created by User on 12/4/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire

struct BookingResponse: Codable {
  let reason: String
  let booking: [Booking]
  let response: Bool
}

struct Booking: Codable {
  let id: Int
  let workTime: String!
  let status: Bool
  let statusNote: String
  let team: Team
  let location: Location
  let service: Service
  
  enum CodingKeys: String, CodingKey {
    case id
    case workTime = "work_time"
    case status
    case statusNote = "status_note"
    case team, location, service
  }
}

struct Location: Codable {
  let id: Int
  let location: String
}

struct Service: Codable {
  let id: Int
  let service: String
}

struct Team: Codable {
  let id: Int
  let team: String
}

