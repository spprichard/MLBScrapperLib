// BS: Baseball Savant - https://baseballsavant.mlb.com

import Foundation
import SwiftSoup

let urlStr = "https://baseballsavant.mlb.com/team/108" // should not scrape from this URL

let html = String(contentsOf: URL(string: urlStr)!)

let doc = try SwiftSoup.parse(html)

let e = try doc.select("html.device-desktop body#team_index.lang-en_US div.article-template section#team section#header div.header-container div.title").first()!
print(e.text())
