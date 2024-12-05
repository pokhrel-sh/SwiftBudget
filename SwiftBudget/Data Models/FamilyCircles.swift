//
//  FamilyCircles.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/4/24.
//

struct User {
    var id: String
    var name: String
    var email: String
    var role: Role
    var familyCircleId: String?
}

enum Role: String {
    case parent = "parent"
    case student = "student" // From dependent
}

struct FamilyCircle {
    var id: String
    var parentId: String
    var studentIds: [String]
}
