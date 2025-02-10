//
//  MassageCardModel.swift
//  MassageDomain
//
//  Created by Andrew Elbert on 1/31/25.
//

import Foundation

struct MassageCardModel: Identifiable {
    var id: UUID
    var name: String
    var imageName: String
    var parlor: String
    var bio: String
}
