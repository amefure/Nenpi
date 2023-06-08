//
//  CustomModifier.swift
//  Nenpi
//
//  Created by t&a on 2023/06/07.
//

import SwiftUI


extension Image {

    func ex_ResizableTopIconModifier() -> some View {
        self
            .resizable(resizingMode: .stretch)
            .frame(width: DeviceSizeViewModel().isSESize ? 100.0 : 150.0, height: DeviceSizeViewModel().isSESize ? 100.0 : 150.0)
            .padding(.bottom,(DeviceSizeViewModel().isSESize ? 30 : 145.0))
            .foregroundColor(Color.white)
    }
}

