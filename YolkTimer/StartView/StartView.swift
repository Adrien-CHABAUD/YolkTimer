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
            Image("Background_YolkTimer")
                .resizable()
                .ignoresSafeArea()
            
            // Interface
            VStack {

                // Top Picker
                Picker("Test", selection: $viewModel.pickerSelection) {
                    ForEach(EggCookState.allCases, id: \.self){ value in
                        Text(value.localizedName).tag(value)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)
                .colorMultiply(Color.color1)
                .onChange(of: viewModel.pickerSelection){ viewModel.selectTime()}
                .disabled(viewModel.isPickerDisabled)
                
                Spacer()
                
                // Main image
                Image("EggImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 211)
                
                Spacer()
            
                // Time formatted
                Text("\(viewModel.timeFormatted())")
                    .font(.largeTitle)
                    .foregroundStyle(Color("TextColor"))
                    .padding(.bottom, 20)
                
                // Bottom Button
                Button(action: {
                    viewModel.isRunning.toggle()
                    if viewModel.isRunning {
                        viewModel.startTimer()
                    } else {
                        viewModel.stopTimer()
                    }
                }, label: {
                    Text(viewModel.isRunning ? "STOP" : "START")
                }).buttonStyle(MainButton())
                
                // Fun Fact
                Text("\(viewModel.factDisplay)")
                    .fontWeight(.light)
                    .italic()
                    .foregroundColor(Color("TextColor"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20.0)
                    .padding(.top, 20.0)
                    .opacity(viewModel.isFactDisabled ? 0 : 1)
                    
                Spacer()
                
            }
        }
    }
}

#Preview {
    StartView()
}
