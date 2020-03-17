//
//  ItemsInList.swift
//  TheGameNews
//
//  Created by 周测 on 3/13/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct ItemsInList: View {
	@ObservedObject private var crawlerData = WebCrawler() // 放入要爬的页数
	
	init(page: Int = 1) {
		self.crawlerData = WebCrawler(url: URL(string: "https://www.wowchina.com/zh-cn/news.frag?page=\(page)")!)
	}
	
	var body: some View {
		VStack {
			NavigationView {
				List(crawlerData.result ?? [CrawlerResult()], id: \.id) { i in
					NavigationLink(destination: WebView(request: i)){
						ListItem(URLData: i)
					}
				}
				.navigationBarTitle(Text("WoW"))
			}

		}
	}
}

struct ItemsInList_Previews: PreviewProvider {
	static var previews: some View {
		ItemsInList(page: 1)
			//.environment(\.colorScheme, .dark)
	}
}
