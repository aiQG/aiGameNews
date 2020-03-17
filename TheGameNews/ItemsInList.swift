//
//  ItemsInList.swift
//  TheGameNews
//
//  Created by 周测 on 3/13/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct ItemsInList: View {
	@State private var page = 1
	@ObservedObject private var crawlerData = WebCrawler() // 放入要爬的页数
	
	
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
			HStack {
				Button(action: {
					self.page = self.page > 0 ? self.page - 1 : 1
				}) {
					Text("     <      ")
						.foregroundColor(.secondary)
						.font(.title)
				}
				Spacer()
				Button(action: {
					self.page = self.page < 100 ? self.page + 1 : 100
				}) {
					Text("      >     ")
						.foregroundColor(.secondary)
						.font(.title)
				}
			}
		}
	}
}

struct ItemsInList_Previews: PreviewProvider {
	static var previews: some View {
		ItemsInList()
			//.environment(\.colorScheme, .dark)
	}
}
