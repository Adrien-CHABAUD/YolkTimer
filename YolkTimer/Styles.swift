//
//  Styles.swift
//  YolkTimer
//
//  Created by Adrien CHABAUD on 2024-04-05.
//

import Foundation
import SwiftUI

struct MainButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 100)
            .font(.title3)
            .padding(.horizontal, 40)
            .foregroundStyle(.black)
            .padding(10)
            .background(Color.color1)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(radius: 2, x:0, y: 4)
        
    }
}
