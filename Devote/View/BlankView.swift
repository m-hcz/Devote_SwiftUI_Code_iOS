//
//  BlankView.swift
//  Devote
//
//  Created by M H on 18/12/2021.
//

import SwiftUI

struct BlankView: View {
	
	// MARK: props
	var backgroundColor: Color
	var backgroundOpacity: Double
	
	// MARK: body
    var body: some View {
		VStack{
			Spacer()
		} // vstack
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
		.background(backgroundColor)
		.opacity(backgroundOpacity)
		.blendMode(.overlay)
		.edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
		BlankView(backgroundColor: .black, backgroundOpacity: 0.3)
			.background(BackgroundImageView())
			.background(bgGradient.ignoresSafeArea(.all))
    }
}
