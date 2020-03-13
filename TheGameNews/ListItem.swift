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
	
	private var imageURL = "http://cms.cnc.blzstatic.cn/cms/blog_thumbnail/t3/T30PTL0IJG3N1536731539320.jpg"
	private var title = "NULL"
	private var content = "null"
	private var date = "*"
	
	init(URLData: CrawlerResult) {
		self.imageURL = URLData.imageLink
		self.title = URLData.title
		self.content = URLData.content
		self.date = URLData.date
	}
	
    var body: some View {
		HStack {
			VStack {
				HStack {
					Text(title)
					Spacer()
				}
				HStack {
					Text(content)
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
				.frame(width: UIScreen.main.bounds.width / 9 * 2, height: UIScreen.main.bounds.width / 9 * 2)
				 .cornerRadius(10)
			.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke(Color.orange, lineWidth: 5)
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
