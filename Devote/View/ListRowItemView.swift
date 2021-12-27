//
//  ListRowItemView.swift
//  Devote
//
//  Created by M H on 18/12/2021.
//

import SwiftUI

struct ListRowItemView: View {
	// MARK: props
	@Environment(\.managedObjectContext) private var viewContext
	@ObservedObject var item: Item
	
    var body: some View {
		Toggle(isOn: $item.completion, label: {
			Text(item.task ?? "")
				.font(.system(.title2, design: .rounded))
				.fontWeight(.heavy)
				.foregroundColor(item.completion ? .pink : .primary)
				.padding(.vertical ,12)
				.animation(.default)
		}) // toggle
			.toggleStyle(CheckboxStyle())
			.onReceive(item.objectWillChange, perform: { _ in
				if self.viewContext.hasChanges {
					try? self.viewContext.save()
				}
			})
    }
}

//struct ListRowItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRowItemView()
//    }
//}
