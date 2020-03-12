//
//  WebCrawler.swift
//  TheGameNews
//
//  Created by 周测 on 3/12/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import Foundation
import Kanna
struct WebCrawler{
	let url = URL(string: "https://www.wowchina.com/zh-cn/news.frag?page=1")!
	
	func call() -> [(String?, String?, String?, String?, String?)] {
		var dic: [(String?, String?, String?, String?, String?)] = []
		let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
			guard let html = data else { return }
			if let doc = try? HTML(html: html, encoding: .utf8) {
				var Link: [String?] = []

				for link in doc.xpath(#"//a[@class="Link NewsBlog-link"]"#) {
					Link += [link["href"] ?? nil]
				}
				
				var imageLink: [String?] = []
				for image in doc.xpath(#"//div[@class="Tile-bg"]"#) {
					imageLink += [image["style"] ?? nil]
				}
				
				var title: [String?] = []
				for tt in doc.xpath(#"//div[@class="NewsBlog-title"]"#) {
					title += [tt.content ?? nil]
				}
				
				var content: [String?] = []
				for c in doc.xpath(#"//p[@class="NewsBlog-desc color-beige-medium font-size-xSmall"]"#) {
					content += [c.content ?? nil]
				}
				
				var date: [String?] = []
				for d in doc.xpath(#"//div[@class="NewsBlog-date LocalizedDateMount"]"#) {
					date += [d.content ?? nil]
				}
				// finally get tuples
				for i in 0..<max(Link.count, imageLink.count, title.count, content.count, date.count) {
					dic.append((Link[i], imageLink[i], title[i], content[i], date[i]))
				}
			}
		}
		task.resume()
		
		return dic
	}
}
