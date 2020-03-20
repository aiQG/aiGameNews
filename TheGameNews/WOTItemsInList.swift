//
//  WOTItemsInList.swift
//  TheGameNews
//
//  Created by 周测 on 3/20/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct WOTItemsInList: View {
	@ObservedObject private var crawlerData = WOTWebCrawler()
	
	init(page: Int = 1) {
		self.crawlerData = WOTWebCrawler(url: URL(string: "http://wot.kongzhong.com/zixun/new_\(page).html")!)
	}
	
	var body: some View {
		VStack{
			if crawlerData.result?.count == 0 {
				Text("没有了")
			}
			List(crawlerData.result ?? [CrawlerResult()], id: \.id) { i in
				NavigationLink(destination: WebView(request: i)){
					WOTListItem(URLData: i)
				}
			}
		}
		.navigationBarTitle(Text("WOT"), displayMode: .inline)
	}
}

struct WOTItemsInList_Previews: PreviewProvider {
	static var previews: some View {
		WOTItemsInList()
	}
}
