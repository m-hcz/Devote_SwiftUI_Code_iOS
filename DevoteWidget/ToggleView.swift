//
//  ToggleView.swift
//  Devote
//
//  Created by M H on 19/12/2021.
//

import SwiftUI

struct ToggleView: View {
	
	// MARK: props
	@Binding var checked:Bool
	var text:String
	
	
	// MARK: body
    var body: some View {
		Toggle(isOn: $checked, label: {
			Text(text)
				.font(.system(.title2, design: .rounded))
				.fontWeight(.heavy)
				.foregroundColor(checked ? .pink : .primary)
				.padding(.vertical ,12)
				.animation(.default)
		}) // toggle
			.toggleStyle(CheckboxStyleWidget())
    }
}

struct ToggleView_Previews: PreviewProvider {
	
	@State static var checked = true
	
    static var previews: some View {
		
		ToggleView(checked: $checked, text: "0")
    }
}
