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

struct funFacts {
    var facts = [
        "The colour of the shell depends on the breed of the hen that laid it.",
        "The colour of the yolk depends on the hen’s diet.",
        "The age of a hen affects the size of an egg.",
        "For the best hard boiled eggs, use eggs that are at least 10 days old.",
        "Fresh eggs are more difficult to peel.",
        "An egg shell can have as many as 17.000 pores.",
        "Egg yolk naturally contains Vitamin D.",
        "Hard cooked eggs spin easily while raw eggs wobble.",
        "In average, hens lay 300 to 325 eggs per year.",
        "The fastest omelet maker in the world made 427 two-egg omelets in 30min.",
        "A hen turns her egg nearly 50 times a day to keep the yolk from sticking to the side.",
        "Kiwis lay the largest eggs in relation to their body size.",
        "The term “Yolk” derives from an Old English word for “Yellow”.",
        "Chickens lay lighter coloured eggs as they age.",
        "Floating eggs are older than sinking eggs."
    ]
}
