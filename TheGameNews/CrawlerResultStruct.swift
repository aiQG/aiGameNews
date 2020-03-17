//
//  ResultStruct.swift
//  TheGameNews
//
//  Created by 周测 on 3/17/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import Foundation

struct CrawlerResult: Identifiable {
	var id: Int = -1
	var link: String = "https://aiqg.vip"
	var imageLink: String = "https://raw.githubusercontent.com/aiQG/aiQG.github.io/master/assets/images/blacktocat.png"
	var title: String = "NULL"
	var content: String = "null"
	var date: String = "***"
}
