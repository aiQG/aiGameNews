//
//  ItemsInList.swift
//  TheGameNews
//
//  Created by 周测 on 3/13/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct WoWItemsInList: View {
	@ObservedObject private var crawlerData = WoWWebCrawler() 
	
	init(page: Int = 1) {
		self.crawlerData = WoWWebCrawler(url: URL(string: "https://www.wowchina.com/zh-cn/news.frag?page=\(page)")!)
	}
	
	var body: some View {
		VStack{
			if crawlerData.result?.count == 0 {
				Text("没有了")
			}
			List(crawlerData.result ?? [CrawlerResult()], id: \.id) { i in
				NavigationLink(destination: WebView(request: i)){
					ListItem(URLData: i)
				}
				
			}
		}
		.navigationBarTitle(Text("WoW"), displayMode: .inline)
	}
}

struct WoWItemsInList_Previews: PreviewProvider {
	static var previews: some View {
		WoWItemsInList(page: 1)
		//.environment(\.colorScheme, .dark)
	}
}
