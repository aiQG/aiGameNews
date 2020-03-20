//
//  EVEWebCrawler.swift
//  TheGameNews
//
//  Created by 周测 on 3/20/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import Foundation
//import Kanna
import Combine


class EVEWebCrawler: ObservableObject{
	var url: URL
	// (ID, Link, Image, Title, Content, Date)
	@Published var result: [CrawlerResult]?
	private(set) var isLoading = false
	
	private var cancellable: AnyCancellable?
	
	private static let imageProcessingQueue = DispatchQueue(label: "EVE-image-processing")
	
	private let domain: String
	
	
	init(url: URL = URL(string: "https://evepc.163.com/news/index.html")!) {
		self.url = url
		self.result = []
		self.domain = "https://evepc.163.com"
		self.call()
	}
	
	func call() {
		
		cancellable = URLSession.shared.dataTaskPublisher(for: url)
			.map{
				var output: [CrawlerResult]? = []
				// check state
				if let state = $0.response as? HTTPURLResponse {
					if state.statusCode != 200 {
						//需要代理
						return output
					}
				} else {
					return output
				}
				let html = $0.data
				if let doc = try? HTML(html: html, encoding: .utf8) {
					
					var Link: [String?] = []
					for i in doc.xpath(#"//ul[@class="list"]/li/a"#) {
						Link += [i["href"] ?? ""]
					}

					var imageLink: [String?] = []
					for image in doc.xpath(#"//ul[@class="list"]/li/a/span[@class="kindname"]"#) {
						switch image["data-name"] {
						case "新闻":
							imageLink += ["EVE_news"]
						case "维护":
							imageLink += ["EVE_update"]
						case "论坛":
							imageLink += ["EVE_BBS"]
						case "媒体":
							imageLink += ["EVE_media"]
						default:
							imageLink += ["EVEicon"]
						}
					}

					var title: [String?] = []
					for i in doc.xpath(#"//ul[@class="list"]/li/a/p[@class="lside"]/span[@class="title"]"#){
						title += [i.content ?? ""]
					}
					
					var content: [String?] = []
					for i in doc.xpath(#"//ul[@class="list"]/li/a/p[@class="lside"]/span[@class="comment"]"#) {
						content += [i.content ?? ""]
					}
					
					var date: [String?] = []
					for d in doc.xpath(#"//ul[@class="list"]/li/a/p[@class="lside"]/span[@class="time"]"#) {
						date += [d.content ?? nil]
					}

					// finally get tuples
					for i in 0..<max(Link.count, imageLink.count, title.count, content.count, date.count) {
						output!.append(
						CrawlerResult(id: i, link: Link.count > i ? Link[i]! : "https://aiqg.vip",
									  imageLink: imageLink.count > i ? imageLink[i]! : "https://raw.githubusercontent.com/aiQG/aiQG.github.io/master/assets/images/blacktocat.png",
									  title: title.count > i ? title[i]! : "NULL",
									  content: content.count > i ? content[i]! : "null",
									  date: date.count > i ? date[i]! : "**"))
					}
				}
				return output
		}
		.replaceError(with: nil)
		.subscribe(on: Self.imageProcessingQueue)
		.receive(on: DispatchQueue.main)
		.assign(to: \.result, on: self)
		
	}
	
	
	func cancel() {
		cancellable?.cancel()
	}
	
	private func onStart() {
		isLoading = true
	}
	
	private func onFinish() {
		isLoading = false
	}
	
}
