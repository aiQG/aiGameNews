//
//  YDNews.swift
//  TheGameNews
//
//  Created by 周测 on 3/19/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct YDNews: View {
	@State private var page = 1
	
	var body: some View {
		VStack {
			YDItemsInList(page: page)
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

struct YDNews_Previews: PreviewProvider {
	static var previews: some View {
		YDNews()
	}
}
