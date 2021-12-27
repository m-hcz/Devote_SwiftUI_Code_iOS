//
//  ContentView.swift
//  Devote
//
//  Created by M H on 18/12/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
	// MARK: props
	@AppStorage("isDarkMode") private var isDarkMode: Bool = false
	
	@State var task: String = ""
	@State private var showNewTaksItem: Bool = false
	
	// fetching data
	@Environment(\.managedObjectContext) private var viewContext
	
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
		animation: .default)
	private var items: FetchedResults<Item>
	
	// MARK: func
	
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			offsets.map { items[$0] }.forEach(viewContext.delete)
			
			do {
				try viewContext.save()
			} catch {
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
	
	// MARK: body
	var body: some View {
		NavigationView {
			ZStack {
				// MARK: main view
				VStack {
					// MARK: header
					HStack(spacing: 10){
						// title
						Text("Devote")
							.font(.system(.largeTitle, design: .rounded))
							.fontWeight(.heavy)
							.padding(.leading, 4)
						
						Spacer()
						
						// edit button
						EditButton()
							.font(.system(size: 16, weight: .semibold, design: .rounded))
							.padding(.horizontal, 10)
							.frame(minWidth: 70, minHeight: 24)
							.background(Capsule().stroke(Color.white, lineWidth:  2))
						
						// appearance button
						Button(action: {
							isDarkMode.toggle()
							playSound(sound: "sound-tap", type: "mp3")
							feedback.notificationOccurred(.success)
						}, label: {
							Image(systemName: isDarkMode ? "sun.max.circle" : "moon.circle" )
								.resizable()
								.frame(width: 24, height: 24)
								.font(.system(.title, design: .rounded))
						}) // button
						
					} // hstack
					.padding()
					.foregroundColor(.white)
					
					Spacer(minLength: 80)
					// MARK: new taks button
					Button(action: {
						showNewTaksItem = true
						playSound(sound: "sound-ding", type: "mp3")
						feedback.notificationOccurred(.success)
					}, label: {
						Image(systemName: "plus.circle")
							.font(.system(size: 30, weight: .bold, design: .rounded))
						Text("New Task")
							.font(.system(size: 30, weight: .bold, design: .rounded))
					}) // button
						.foregroundColor(.white)
						.padding(.horizontal, 20)
						.padding(.vertical, 15)
						.background(
							bgGradient.clipShape(Capsule())
						)
						.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0, y: 4)
					
					// MARK: tasks
					
					List {
						ForEach(items) { item in
							ListRowItemView(item: item)
						} // loop
						.onDelete(perform: deleteItems)
					} // list
					.listStyle(InsetGroupedListStyle())
					.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
					.padding(.vertical, 0)
					.frame(maxWidth: 640)
				} // vstack
				.blur(radius: showNewTaksItem ? 8.0 : 0, opaque: false)
				.transition(.move(edge: .bottom))
				.animation(.easeOut(duration: 0.5))
				
				  // MARK: new task item
				
				if showNewTaksItem {
					BlankView(backgroundColor: isDarkMode ? .black : .gray, backgroundOpacity: isDarkMode ? 0.3 : 0.5)
						.onTapGesture {
							withAnimation(){
								showNewTaksItem = false
							}
						}
					NewTaskItemView(isShowing: $showNewTaksItem)
				}
			} // zstack
			.onAppear(perform: {
				UITableView.appearance().backgroundColor = .clear
			})
			.navigationBarTitle("Daily Tasks", displayMode: .large)
			.navigationBarHidden(true)
			.background(
				BackgroundImageView()
					.blur(radius: showNewTaksItem ? 8.0 : 0, opaque: false)
			)
			.background(bgGradient.ignoresSafeArea(.all))
			Text("Select an item")
		} // navview
		.navigationViewStyle(StackNavigationViewStyle())
	} // body
}



// MARK: preview
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
