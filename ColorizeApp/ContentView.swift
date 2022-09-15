//
//  ContentView.swift
//  ColorizeApp
//
//  Created by igor s on 13.09.2022.
//

import SwiftUI

enum FocusFiled {
    case red, green, blue
}

struct ContentView: View {
    
    @State private var red = Double.random(in: 0...255).rounded()
    @State private var green = Double.random(in: 0...255).rounded()
    @State private var blue = Double.random(in: 0...255).rounded()
    
    @FocusState private var focusField: FocusFiled?
    
    let color = CGColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, Color(color)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .onTapGesture {
                focusField = nil
            }
            
            VStack(spacing: 50) {
                Color(red: red/255, green: green/255, blue: blue/255)
                    .frame(maxWidth: .infinity, maxHeight: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 4))
                
                VStack {
                    ColorSliderView(value: $red, sliderColor: .red)
                        .focused($focusField, equals: .red)
                    ColorSliderView(value: $green, sliderColor: .green)
                        .focused($focusField, equals: .green)
                    ColorSliderView(value: $blue, sliderColor: .blue)
                        .focused($focusField, equals: .blue)
                    
                }
                .keyboardType(.numberPad)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button(action: focusedUp) {
                            Image(systemName: "chevron.up")
                        }
                        Button(action: focusDown ) {
                            Image(systemName: "chevron.down")
                        }
                        Spacer()
                        Button("Done") {
                            focusField = nil
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

extension ContentView {
    
    private func focusedUp() {
        switch focusField {
        case .red:
            focusField = .blue
        case .green:
            focusField = .red
        case .blue:
            focusField = .green
        case .none:
            focusField = nil
        }
    }
    
    private func focusDown() {
        switch focusField {
        case .red:
            focusField = .green
        case .green:
            focusField = .blue
        case .blue:
            focusField = .red
        case .none:
            focusField = nil
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
