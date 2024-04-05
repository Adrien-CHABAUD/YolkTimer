//
//  StartView.swift
//  YolkTimer
//
//  Created by Adrien CHABAUD on 2024-04-05.
//

import SwiftUI

struct StartView: View {
    
    // ViewModel
    @ObservedObject var viewModel = StartViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundColor1
                .ignoresSafeArea()
            
            // Interface
            VStack {
                Spacer()
                
                // Top buttons
                Picker("Test", selection: $viewModel.pickerSelection) {
                    ForEach(EggCookState.allCases, id: \.self){ value in
                        Text(value.localizedName).tag(value)
                    }
                }
                .pickerStyle(.segmented)
                .colorMultiply(Color.color1)
                .background(Color.color2)
                .onChange(of: viewModel.pickerSelection){ print($viewModel.pickerSelection.wrappedValue)}
                .padding(.horizontal, 10)
                
                Spacer()
                
                Image("EggImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 211)
                
                Spacer()
            
                Text("03:00")
                    .font(.largeTitle)
                    .foregroundStyle(Color("TextColor"))
                    .padding(.bottom, 20)
                
                Button(action: {}, label: {
                    Text("START")
                }).buttonStyle(MainButton())
                
                Spacer()
                
                
            }
        }
    }
}

#Preview {
    StartView()
}
