//
//  EVEItemsInList.swift
//  TheGameNews
//
//  Created by 周测 on 3/20/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct EVEItemsInList: View {
	@ObservedObject private var crawlerData = EVEWebCrawler()
	
	init(page: Int = 1) {
		self.crawlerData = EVEWebCrawler(url: URL(string: "https://evepc.163.com/news/index\(page == 1 ? "" : "_\(page)").html")!)
	}
	
	var body: some View {
		VStack{
			if crawlerData.result?.count == 0 {
				Text("没有了")
			}
			List(crawlerData.result ?? [CrawlerResult()], id: \.id) { i in
				NavigationLink(destination: WebView(request: i)){
					EVEListItem(URLData: i)
					
				}
			}
		}
		.navigationBarTitle(Text("EVE Online"), displayMode: .inline)
	}
}

struct EVEItemsInList_Previews: PreviewProvider {
	static var previews: some View {
		EVEItemsInList()
	}
}
