//
//  ColorShapeStyle.swift
//  Moonshot
//
//  Created by @andreev2k on 13.09.2022.
//

import SwiftUI

// расширение для пользовательских цветов
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
    }
