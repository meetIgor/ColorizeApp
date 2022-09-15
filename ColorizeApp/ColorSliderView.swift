//
//  ColorSliderView.swift
//  ColorizeApp
//
//  Created by igor s on 15.09.2022.
//

import SwiftUI

struct ColorSliderView: View {
    @Binding var value: Double
    @State private var textValue = ""
    
    let sliderColor: Color
    
    var body: some View {
        HStack {
            Text(value, format: .number)
                .foregroundColor(.white)
                .frame(width: 40)
                .font(.system(size: 18))
            
            Slider(value: $value, in: 0...255, step: 1)
                .tint(sliderColor)
                .onChange(of: value) { newValue in
                    textValue = value.formatted()
                }
            
            TextFieldView(textValue: $textValue, numberValue: $value)
            
        }
        .onAppear {
            textValue = value.formatted()
        }
    }
}

struct ColorSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSliderView(value: .constant(100), sliderColor: .red)
    }
}
