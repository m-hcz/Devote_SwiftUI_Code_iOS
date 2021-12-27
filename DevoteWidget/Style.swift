//
//  Style.swift
//  Devote
//
//  Created by M H on 19/12/2021.
//

import SwiftUI

struct CheckboxStyleWidget: ToggleStyle {
	func makeBody(configuration: Configuration) -> some View {
		return HStack{
			Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
				.foregroundColor(configuration.isOn ? .pink : .primary)
				.font(.system(size: 30, weight: .semibold, design: .rounded))
				.onTapGesture {
					configuration.isOn.toggle()
				}
			
			configuration.label
		} // hstack
	}
}

struct CheckboxStyleWidget_Previews: PreviewProvider {
	static var previews: some View {
		Toggle("Placeholder label", isOn: .constant(false))
			.toggleStyle(CheckboxStyleWidget())
			.padding()
			.previewLayout(.sizeThatFits)
	}
}
