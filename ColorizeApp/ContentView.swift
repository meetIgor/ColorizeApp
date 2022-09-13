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
    
    @State private var showAlert = false
    
    @FocusState private var focusField: FocusFiled?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                Color(red: red/255, green: green/255, blue: blue/255)
                    .frame(maxWidth: .infinity, maxHeight: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 4))
                
                VStack {
                    HStack {
                        ColorSliderView(value: $red, sliderColor: .red, textColor: .white)
                        TextFieldView(value: $red)
                            .focused($focusField, equals: .red)
                    }
                    HStack {
                        ColorSliderView(value: $green, sliderColor: .green, textColor: .white)
                        TextFieldView(value: $green)
                            .focused($focusField, equals: .green)
                        
                    }
                    HStack {
                        ColorSliderView(value: $blue, sliderColor: .blue, textColor: .white)
                        TextFieldView(value: $blue)
                            .focused($focusField, equals: .blue)
                        
                    }
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
                        Button("Done", action: checkValue)
                            .alert("Wrong Format", isPresented: $showAlert, actions: {}) {
                                Text("Please enter value from 0 to 255")
                            }
                    }
                }
                
                Spacer()
                
            }
            .padding()
        }
    }
    
    private func focusedUp() {
        switch focusField {
        case .red:
            focusField = .blue
        case .green:
            focusField = .red
        case .blue:
            focusField = .green
        case .none:
            return
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
            return
        }
    }
    
    private func checkValue() {
        switch focusField {
        case .some(.red):
            if !(0...255).contains(red) {
                showAlert.toggle()
                return
            }
        case .green:
            if !(0...255).contains(green) {
                showAlert.toggle()
                return
            }
        case .blue:
            if !(0...255).contains(blue) {
                showAlert.toggle()
                return
            }
        case .none:
            return
        }
        
        focusField = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSliderView: View {
    @Binding var value: Double
    let sliderColor: Color
    let textColor: Color
    
    var body: some View {
        HStack {
            Text(value, format: .number)
                .foregroundColor(textColor)
                .frame(width: 40)
                .font(.system(size: 18))
            
            Slider(value: $value, in: 0...255, step: 1)
                .tint(sliderColor)
            
        }
    }
}

struct TextFieldView: View {
    @Binding var value: Double
    
    var body: some View {
        TextField("", value: $value, format: .number)
            .frame(width: 50)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
            .font(.system(size: 18))
    }
    
}
