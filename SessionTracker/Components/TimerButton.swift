//
//  Button.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 05/01/24.
//

import SwiftUI

struct TimerButton: View {
    
    let color: Color
    let image: String
    
    var body: some View {
        
            Image(systemName: image)
                .frame(
                    width: 36,
                    height: 36
                )
                .foregroundColor(.black)
                .font(.system(size: 36))
                .bold()
                .padding(24)
                .background(
                    Circle()
                        .fill(.white)
                        .stroke(.black, lineWidth: 3)
                        .background(
                            Circle()
                                .fill(color)
                                .stroke(.black, lineWidth: 3)
                                .offset(x: 8, y: 8)
                        )
                )
                .padding(8)

    }
}

#Preview {
    TimerButton(color: .blue, image: "pause.fill")
}
