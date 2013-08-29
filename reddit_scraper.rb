require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("http://www.reddit.com/r/technology"))
reddit = page.css('html body.listing-page.hot-page div.content div.spacer div#siteTable.sitetable.linklisting a.title')
image = page.css('html body.listing-page.hot-page div#header div#header-bottom-left a#header-img-a img#header-img')
page_title = page.css('html body.listing-page.hot-page div#header div#header-bottom-left span.hover.pagename.redditname')

File.open('reddit_styled.html', 'w') do |f|
	f.puts("<html>")
	f.puts("<head>")
	f.puts('<link type="text/css" rel="stylesheet" href="reddit_stylesheet.css">')
	f.puts("<link href='http://fonts.googleapis.com/css?family=Droid+Sans' rel='stylesheet' type='text/css'>")
	f.puts("<link href='http://fonts.googleapis.com/css?family=Actor' rel='stylesheet' type='text/css'>")
	f.puts("    <title>Reddit Lookin' Good</title>")
	f.puts("</head>")
	f.puts("<body>")
	f.puts('<div id="container">')
	f.puts('<div class="header_footer" id="header">'+"\n#{image}"+"\n#{page_title}"+"</div>")
	f.puts("    <ul>")

	reddit.each_with_index do |link, i|
		title = link.text.gsub(/’/, "&apos;")
		title = title.gsub(/“/, "&quot;")
		title = title.gsub(/”/, "&quot;")
		title = title.gsub(/—/, "-")
		title = title.gsub(/‘/, "&apos;")
			if i%2==0
			f.puts("<li><a class='card_link' href=\"#{link['href']}\"><div class='card1'>#{title}</div></a></li>\n")
			else
			f.puts("<li><a class='card_link' href=\"#{link['href']}\"><div class='card2'>#{title}</div></a></li>\n")
			end
		end
		#f.puts("<div class='card'>""<li>" + title + "</li>""</div>")
	
	f.puts("   </ul>")
	f.puts("</div>")
	f.puts("</body>\n")
	f.puts("</html>\n")

end

