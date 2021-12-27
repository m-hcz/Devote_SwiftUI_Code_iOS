//
//  Constant.swift
//  Devote
//
//  Created by M H on 18/12/2021.
//

import SwiftUI


// MARK: formater
let itemFormatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateStyle = .short
	formatter.timeStyle = .medium
	return formatter
}()

// MARK: UI
var bgGradient: LinearGradient {
	return LinearGradient(gradient: Gradient(colors: [.pink,.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}


// MARK: UX
let feedback = UINotificationFeedbackGenerator()
