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
                // Top buttons
                Picker("Test", selection: $viewModel.pickerSelection) {
                    ForEach(EggCookState.allCases, id: \.self){ value in
                        Text(value.localizedName).tag(value)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)
                .colorMultiply(Color.color1)
                .onChange(of: viewModel.pickerSelection){ print($viewModel.pickerSelection.wrappedValue)}
                
                Spacer()
                
                Image("EggImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 211)
                
                Spacer()
            
                Text("\(viewModel.pickerSelection.rawValue == "Runny" ? "3:00" : viewModel.pickerSelection.rawValue == "Soft" ? "6:00" : "9:00")")
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
