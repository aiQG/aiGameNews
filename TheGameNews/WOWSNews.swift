//
//  WOWSNews.swift
//  TheGameNews
//
//  Created by 周测 on 3/20/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct WOWSNews: View {
	@State private var page = 1
	
	var body: some View {
		VStack {
			WOWSItemsInList(page: page)
			Spacer()
			HStack {
				Button(action: {
					self.page = self.page > 1 ? self.page - 1 : 1
				}) {
					Text("     <      ")
						.foregroundColor(.secondary)
						.font(.title)
				}
				Spacer()
				Text("\(page)")
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

struct WOWSNews_Previews: PreviewProvider {
	static var previews: some View {
		WOWSNews()
	}
}
