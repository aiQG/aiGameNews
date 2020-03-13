//
//  ItemsInList.swift
//  TheGameNews
//
//  Created by 周测 on 3/13/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI

struct ItemsInList: View {
	@ObservedObject private var crawlerData = WebCrawler()
	
	
    var body: some View {
		List(crawlerData.result ?? [CrawlerResult()], id: \.id) { i in
			ListItem(URLData: i)
		}
    }
}

struct ItemsInList_Previews: PreviewProvider {
    static var previews: some View {
        ItemsInList()
    }
}
