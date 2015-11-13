require 'nokogiri'
require 'open-uri'

module Scraper

	def Scraper.find_moves_in(url, tag, matcher)
		content = Nokogiri::HTML(open(url)) 
		element = content.xpath(tag)
		temp = element.to_s.scan matcher
		moves = temp.fetch(0, []).fetch(0, [])
		moves.split(",") if !moves.empty?
	end
end

class ChessSite
	def initialize(base_url, range, tag, start_match, end_match)
		@base_url = base_url
		@range = range
		@tag = tag
		@matcher = /#{start_match}(.*?)#{end_match}/
		@move_list = {}
	end

	def move_library
		(@range[0]..@range[1]).each do |game|
			url = "#{@base_url}#{game.to_s}"
			moves = Scraper.find_moves_in(url, @tag, @matcher)
			@move_list[game] = moves.nil? ? [] : moves
		end
	end

	def print_moves
		if @move_list.empty?
			puts "no moves list"
		else
			@move_list.each { |k, m| puts "Game: #{k} => #{m.join(',')}" }
		end
	end
end

def main
	tag = "//script"
	start_match = "\\:\\["
	end_match = "\\]\\,"
	range = [1000000, 1000010]
	base_url = "http://chesstempo.com/gamedb/game/"

	site = ChessSite.new(base_url, range, tag, start_match, end_match)
	site.move_library
	site.print_moves
end

if __FILE__ == $0
	main
end

