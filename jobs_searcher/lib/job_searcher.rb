require 'rubygems'
require 'nokogiri'
require 'open-uri'

base_url = 'http://www.indeed.com/'
endpoint = 'jobs?q=software+engineer&l=Portland, OR'

url = base_url + endpoint
encoded = URI.encode(url)

page = Nokogiri::HTML(open(encoded))
puts page.class

element = page.xpath("//a")
result = element.collect { |x| x if !x.attributes["data-tn-element"].nil? }.compact


job_url = base_url + 'rc/clk?jk=47f537df21b12ca3'
encoded_job = URI.encode(job_url)
job = Nokogiri::HTML(open(encoded_job, allow_redirections => :all))
