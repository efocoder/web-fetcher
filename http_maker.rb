require 'faraday'
require_relative 'page_processor'

class HttpMaker
  def self.make_request(url:, meta: false)
    if url.nil?
      puts "Url cannot be empty"
    else
      begin
        response = conn.get(url)
        if response.success?
          processor = PageProcessor.new(raw_page: response.body, url: url, meta: meta)
          processor.process_file
        else
          puts "Failed to fetch.rb the web page from #{url}. Status code: #{response.status}, reason: #{response.body}"
        end
      rescue Faraday::Error => e
        puts "Error occurred while fetching #{url}: #{e.message}"
      rescue StandardError => e
        puts "Unexpected error occurred: #{e.message}"
      end
    end
  end

  private

  def self.conn
    Faraday.new(headers: { 'Content-Type' => 'application/html' })
  end
end
