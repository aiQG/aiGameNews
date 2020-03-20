//
//  YDListItem.swift
//  TheGameNews
//
//  Created by 周测 on 3/19/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct YDListItem: View {
	let cache = TemporaryImageCache()
	
	//	private var imageURL = "https://raw.githubusercontent.com/aiQG/aiQG.github.io/master/assets/images/blacktocat.png"
	private var title = "NULL"
	//	private var content = "null"
	private var date = "*"
	
	init(URLData: CrawlerResult) {
		//		self.imageURL = URLData.imageLink
		
		self.title = URLData.title //String(URLData.title[...titleBound])
		//		let contentBound = URLData.content.index(URLData.content.startIndex, offsetBy: URLData.content.count > 24 ? 24 : URLData.content.count - 1)
		//		self.content = String(URLData.content[...contentBound]) + (URLData.content.count > 24 ? "..." : "")
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

struct YDListItem_Previews: PreviewProvider {
	static var previews: some View {
		YDListItem(URLData: CrawlerResult())
			.previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 100))
	}
}
