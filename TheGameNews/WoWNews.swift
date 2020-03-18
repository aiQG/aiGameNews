//
//  WoWNews.swift
//  TheGameNews
//
//  Created by 周测 on 3/17/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct WoWNews: View {
	@State private var page = 2
	
	var body: some View {
		VStack {
			WoWItemsInList(page: page)
			HStack {
				Button(action: {
					self.page = self.page > 2 ? self.page - 1 : 2
				}) {
					Text("     <      ")
						.foregroundColor(.secondary)
						.font(.title)
				}
				Spacer()
				Button(action: {
					self.page = self.page < 100 ? self.page + 1 : 99
				}) {
					Text("      >     ")
						.foregroundColor(.secondary)
						.font(.title)
				}
			}
		}
	}
}

struct WoWNews_Previews: PreviewProvider {
	static var previews: some View {
		WoWNews()
	}
}
