//
//  YDItemsInList.swift
//  TheGameNews
//
//  Created by 周测 on 3/19/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct YDItemsInList: View {
	@ObservedObject private var crawlerData = YDWebCrawler()
	
	init(page: Int = 1) {
		self.crawlerData = YDWebCrawler(url: URL(string: "https://lol.qq.com/gicp/news/663/2/1983/\(page).html")!)
	}
	
	var body: some View {
		VStack{
			if crawlerData.result?.count == 0 {
				Text("没有了")
			}
			List(crawlerData.result ?? [CrawlerResult()], id: \.id) { i in
				NavigationLink(destination: WebView(request: i)){
					YDListItem(URLData: i)
					
				}
			}
		}
		.navigationBarTitle(Text("云顶之弈"), displayMode: .inline)
	}
}

struct YDItemsInList_Previews: PreviewProvider {
	static var previews: some View {
		YDItemsInList()
	}
}
