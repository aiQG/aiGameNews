//
//  EFTItemsInList.swift
//  TheGameNews
//
//  Created by 周测 on 3/18/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct EFTItemsInList: View {
	@ObservedObject private var crawlerData = EFTWebCrawler()
	
	
	var body: some View {
		List(crawlerData.result ?? [CrawlerResult()], id: \.id) { i in
			NavigationLink(destination: WebView(request: i)){
				ListItem(URLData: i)
			}
		}
		.navigationBarTitle(Text("EFT"))
	}
}

struct EFTItemsInList_Previews: PreviewProvider {
	static var previews: some View {
		EFTItemsInList()
		//.environment(\.colorScheme, .dark)
	}
}
