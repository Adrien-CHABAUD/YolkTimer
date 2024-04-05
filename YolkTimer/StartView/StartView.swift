//
//  StartView.swift
//  YolkTimer
//
//  Created by Adrien CHABAUD on 2024-04-05.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            Color.backgroundColor1
                .ignoresSafeArea()
            
            VStack {
                // Display background rectangles + offset them
                backgroundRectangle()
                    .offset(x:-70, y:200)
                backgroundRectangle()
                    .offset(x: 100, y: -100)
            }
            
        }
    }
    
    // Handle base settings of the background rectangle
    fileprivate func backgroundRectangle() -> some View {
        return Rectangle()
            .foregroundStyle(Color.backgroundColor2)
            .rotationEffect(Angle(degrees: 41))
            .frame(width: 300, height: 794)
    }
}

#Preview {
    StartView()
}
