//
//  StartView.swift
//  YolkTimer
//
//  Created by Adrien CHABAUD on 2024-04-05.
//

import SwiftUI

struct StartView: View {
    
    private static var formatter: DateComponentsFormatter = {
       let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        formatter.allowsFractionalUnits = true
        return formatter
    }()
    
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
                Image(viewModel.selectPicture())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                
                Spacer()
            
                // Time formatted
                Text("\(elapsedTimeStr(timeInterval: self.viewModel.remainingTime))")
                    .font(.largeTitle)
                    .foregroundStyle(Color("TextColor"))
                    .padding(.bottom, 20)
                
                // Bottom Button
                Button(action: {
                    viewModel.isRunning.toggle()
                }, label: {
                    Text(viewModel.isRunning ? "PAUSE" : "START")
                }).buttonStyle(MainButton())
                
                Button(action: {
                    self.viewModel.reset()
                }, label: {
                    Text("RESET")
                }).disabled(self.viewModel.isResetDisabled())
                    .opacity(self.viewModel.isResetDisabled() ? 0 : 1)
                .buttonStyle(SecondaryButton())
                
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
    
    private func elapsedTimeStr(timeInterval: TimeInterval) -> String {
        return StartView.formatter.string(from: timeInterval) ?? ""
    }
}

#Preview {
    StartView()
}
