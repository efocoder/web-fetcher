#!/usr/bin/env ruby

require_relative 'http_maker'

class Fetch
  def self.make_fetch(argv)
    if argv.empty?
      puts 'No url supplied, please provide a url to continue'
    else
      if argv.include?('--metadata')
        meta_index = argv.index('--metadata')
        argv.delete_at(meta_index) if meta_index

        argv.each do |url|
          HttpMaker.make_request(url: url, meta: true)
        end
      else
        argv.each do |url|
          HttpMaker.make_request(url: url)
        end
      end
    end
  end
end



if __FILE__ == $0
  Fetch.make_fetch(ARGV.uniq)
end
