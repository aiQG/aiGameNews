//
//  WOTListItem.swift
//  TheGameNews
//
//  Created by 周测 on 3/20/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct WOTListItem: View {
	let cache = TemporaryImageCache()
	
	private var title = "NULL"
	private var date = "*"
	
	init(URLData: CrawlerResult) {
		self.title = URLData.title //String(URLData.title[...titleBound])
		self.date = URLData.date
	}
	
	var body: some View {
		HStack {
			VStack {
				HStack {
					Text(title)
						.fontWeight(.bold)
					Spacer()
				}
				Spacer()
				HStack {
					Text(date)
						.foregroundColor(.gray)
					Spacer()
				}
			}
			Spacer()
		}
	}
}

struct WOTListItem_Previews: PreviewProvider {
	static var previews: some View {
		WOTListItem(URLData: CrawlerResult())
	}
}
