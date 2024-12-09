//
//  FamilyCircles.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/4/24.
//
import FirebaseFirestore

struct User {
    var name: String
    var email: String
    var role: Role?
    var parentEmail: String
}

enum Role: String {
    case parent = "parent"
    case student = "student"
}

struct FamilyCircle: Codable {
    var name: String
    var email: String
}

struct Expense {
    var name: String
    var price: Double
    var date: Date
    var image: String // URL or local image path
    var addedBy: String
    var for_user: String
}

struct Budget {
    var name: String
    var amount: Double
    var date: Date
    var image: String = "" // URL or local image path
    var addedBy: String
    var for_user: String
}


