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
    case student = "student"
}

struct FamilyCircle {
    var id: String
    var parentId: String
    var studentIds: [String]
}

struct Expense {
    var name: String
    var price: Double
    var date: String
    var image: String // URL or local image path
    var addedBy: String
    var for_user: String
}

