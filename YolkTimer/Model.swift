//
//  Model.swift
//  YolkTimer
//
//  Created by Adrien CHABAUD on 2024-04-05.
//

import Foundation
import SwiftUI

enum EggCookState: String, Equatable, CaseIterable {
    case runnyState = "Runny"
    case softState = "Soft"
    case hardState = "Hard"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue)}
}
