//
//  WOWSItemsInList.swift
//  TheGameNews
//
//  Created by 周测 on 3/20/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct WOWSItemsInList: View {
    @ObservedObject private var crawlerData = WOWSWebCrawler()
	
	init(page: Int = 1) {
		self.crawlerData = WOWSWebCrawler(url: URL(string: "http://wows.kongzhong.com/2018wows/newlist/index_\(page).html")!)
	}
	
	var body: some View {
		VStack{
			if crawlerData.result?.count == 0 {
				Text("没有了")
			}
			List(crawlerData.result ?? [CrawlerResult()], id: \.id) { i in
				NavigationLink(destination: WebView(request: i)){
					WOWSListItem(URLData: i)
				}
			}
		}
		.navigationBarTitle(Text("EFT"), displayMode: .inline)
	}
}

struct WOWSItemsInList_Previews: PreviewProvider {
    static var previews: some View {
        WOWSItemsInList()
    }
}
