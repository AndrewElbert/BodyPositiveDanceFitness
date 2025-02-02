//
//  AnimatedBulletPointViewState.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/2/25.
//

struct AnimatedBulletPointViewState {
    var text: String
    var emoji: String
    var isAnimating: Bool
    var sparkleOpacity: Double
    
    init(
        text: String = "",
        emoji: String = "",
        isAnimating: Bool = false,
        sparkleOpacity: Double = 0
    ) {
        self.text = text
        self.emoji = emoji
        self.isAnimating = isAnimating
        self.sparkleOpacity = sparkleOpacity
    }
}
