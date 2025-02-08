//
//  SFProFonts.swift
//  Common
//
//  Created by Andrew Elbert on 2/8/25.
//

import SwiftUI

extension Font {
    
    // body text (smaller sizes)
    
    static func sfProBodyTextRegular(size: CGFloat) -> Font {
        .system(size: size, weight: .regular, design: .default)
    }

    static func sfProBodyTextMedium(size: CGFloat) -> Font {
        .system(size: size, weight: .medium, design: .default)
    }

    static func sfProBodyTextSemibold(size: CGFloat) -> Font {
        .system(size: size, weight: .semibold, design: .default)
    }

    static func sfProBodyTextBold(size: CGFloat) -> Font {
        .system(size: size, weight: .bold, design: .default)
    }
    
    static func sfProBodyTextThin(size: CGFloat) -> Font {
        .system(size: size, weight: .thin, design: .default)
    }

    // large titles and headlines
    static func sfProDisplayRegular(size: CGFloat) -> Font {
        .system(size: size, weight: .regular, design: .serif)
    }

    static func sfProDisplayMedium(size: CGFloat) -> Font {
        .system(size: size, weight: .medium, design: .serif)
    }

    static func sfProDisplaySemibold(size: CGFloat) -> Font {
        .system(size: size, weight: .semibold, design: .serif)
    }

    static func sfProDisplayBold(size: CGFloat) -> Font {
        .system(size: size, weight: .bold, design: .serif)
    }

    // More friendly, casual look, action items like buttons
    
    static func sfProRoundedTextRegular(size: CGFloat) -> Font {
        .system(size: size, weight: .regular, design: .rounded)
    }

    static func sfProRoundedTextMedium(size: CGFloat) -> Font {
        .system(size: size, weight: .medium, design: .rounded)
    }

    static func sfProRoundedTextSemibold(size: CGFloat) -> Font {
        .system(size: size, weight: .semibold, design: .rounded)
    }

    static func sfProRoundedTextBold(size: CGFloat) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }
    
    static func sfProRoundedTextThin(size: CGFloat) -> Font {
        .system(size: size, weight: .thin, design: .rounded)
    }


    // More formal, elegant look
    static func sfProSerifRegular(size: CGFloat) -> Font {
        .system(size: size, weight: .regular, design: .serif)
    }

    static func sfProSerifMedium(size: CGFloat) -> Font {
        .system(size: size, weight: .medium, design: .serif)
    }

    static func sfProSerifSemibold(size: CGFloat) -> Font {
        .system(size: size, weight: .semibold, design: .serif)
    }

    static func sfProSerifBold(size: CGFloat) -> Font {
        .system(size: size, weight: .bold, design: .serif)
    }
}
