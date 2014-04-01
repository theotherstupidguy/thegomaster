#URL = 'http://gobase.org/studying/analysed/'
URL = 'http://gogameguru.com/go-commentary-kono-rin-vs-iyama-yuta-38th-gosei-game-5/'

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uri'

=begin
#TODO download sgf only if the page contains "Honinbo Shusaku" in it!
doc = Nokogiri::HTML(open("http://www.amazon.com/Invincible-Games-Shusaku-Game-Collections/dp/4906574017"))
p doc.at('div:contains("Honinbo Shusaku")').text.strip
=end

# gets all the sgfs from a url
def make_absolute( href, root )
  URI.parse(root).merge(URI.parse(href)).to_s
end

Nokogiri::HTML(open(URL)).xpath("//a/@href").each do |src|
  if src.value.end_with? ".sgf"
    begin
      p src.value
      uri = make_absolute(src,URL)
      File.open(File.basename(uri),'wb'){ |f| f.write(open(uri).read) }
    rescue OpenURI::HTTPError => e
      if e.message == '404 Not Found'
	# handle 404 error
      else
       p "can't get this one"
	#raise e
      end
    end
  end
end
