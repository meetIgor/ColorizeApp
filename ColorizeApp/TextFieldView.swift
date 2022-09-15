//
//  TextFieldView.swift
//  ColorizeApp
//
//  Created by igor s on 15.09.2022.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var textValue: String
    @Binding var numberValue: Double
    
    @State private var showAlert = false
    
    @FocusState private var focusField: Bool
    
    var body: some View {
        TextField("", text: $textValue)
            .focused($focusField)
            .frame(width: 50)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
            .font(.system(size: 18))
            .alert("Wrong Format", isPresented: $showAlert, actions: {}) {
                Text("Please, enter value from 0 to 255")
            }
            .onChange(of: focusField) { newValue in
                withAnimation {
                    check()
                }
            }
    }
    
    private func check() {
        if let number = Int(textValue), (0...255).contains(number) {
            numberValue = Double(number)
            return
        }
        showAlert.toggle()
        numberValue = 0
        textValue = "0"
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(textValue: .constant("5"), numberValue: .constant(8))
    }
}
