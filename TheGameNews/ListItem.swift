//
//  ListItem.swift
//  TheGameNews
//
//  Created by 周测 on 3/13/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct ListItem: View {
	let cache = TemporaryImageCache()
	
	private var imageURL = "https://raw.githubusercontent.com/aiQG/aiQG.github.io/master/assets/images/blacktocat.png"
	private var title = "NULL"
	private var content = "null"
	private var date = "*"
	
	init(URLData: CrawlerResult) {
		self.imageURL = URLData.imageLink
		
		self.title = URLData.title //String(URLData.title[...titleBound])
		self.date = URLData.date
		guard URLData.content.count > 0 else {
			self.content = ""
			return
		}
		let contentBound = URLData.content.index(URLData.content.startIndex, offsetBy: URLData.content.count > 24 ? 24 : URLData.content.count - 1)
		self.content = String(URLData.content[...contentBound]) + (URLData.content.count > 24 ? "..." : "")
	}
	
	var body: some View {
		HStack {
			VStack {
				HStack {
					Text(title)
						.fontWeight(.bold)
					Spacer()
				}
				HStack {
					Text(content)
						.font(.system(size: 15))
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
			AsyncImage(url: URL(string: imageURL)!, cache: self.cache, placeholder: Text("Loading ..."), configuration: { $0.resizable() })
				.aspectRatio(contentMode: .fill)
				.frame(width: UIScreen.main.bounds.width / 9 * 2, height: UIScreen.main.bounds.width / 9 * 2)
				.cornerRadius(10)
				.overlay(
					RoundedRectangle(cornerRadius: 10)
						.stroke(Color.gray, lineWidth: 4)
			)
		}
	}
}

struct ListItem_Previews: PreviewProvider {
	static var previews: some View {
		ListItem(URLData: CrawlerResult())
			.previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 100))
	}
}
