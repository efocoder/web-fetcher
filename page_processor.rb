require 'nokogiri'
require 'uri'
require 'fileutils'


class PageProcessor
  attr_accessor :meta, :page, :url

  def initialize(raw_page: , url: , meta: false )
    @meta = meta
    @page = raw_page
    @url = url
  end

  def process_file
    format_page
  end

  private

  def format_page
    doc = Nokogiri::HTML(@page)
    save_page(doc)

    if @meta
      meta_data(doc)
    end
  end

  def save_page(doc)
    File.open(make_file_name, 'wb') do |file|
      file.write(doc.to_html)
    end

    # %w[link[rel="stylesheet"] script[src] img].each do |selector|
    #   get_asset(doc, selector)
    # end
  end

  def make_file_name
    "#{URI(@url).host}.html"
  end

  def meta_data(doc)
    num_links = doc.css('a').size
    num_images = doc.css('img').size
    last_fetch = Time.now.utc

    puts "site: #{URI(@url).host}"
    puts "num_links: #{num_links}"
    puts "images: #{num_images}"
    puts "last_fetch: #{last_fetch}"
  end

  def download_assets(absolute_url)
    assets_dir = File.join(Dir.pwd, make_file_name.gsub('.html', ''))
    FileUtils.mkdir_p(assets_dir)

    open(absolute_url) do |asset|
      File.open(assets_dir, 'wb') do |file|
        file.write(asset.read)
      end
    end
  end

  def get_asset(doc, selector)
    doc.css(selector).each do |link|
      url = link['href'] || link['src']
      next if url.nil?

      absolute_url = URI.join(@url, url).to_s
      download_assets(absolute_url)
    end
  end
  #
  # def downlaod_css(doc)
  #   doc.css('link[rel="stylesheet"]').each do |link|
  #     url = link['href']
  #     next if url.nil?
  #
  #     absolute_url = URI.join(@url, url).to_s
  #     download_assets(absolute_url)
  #   end
  # end
  #
  # def downlaod_imgs(doc)
  #   doc.css('img').each do |link|
  #     url = link['src']
  #     next if url.nil?
  #
  #     absolute_url = URI.join(@url, url).to_s
  #     download_assets(absolute_url)
  #   end
  # end
  #
  # def downlaod_scripts(doc)
  #   doc.css('script[src]').each do |link|
  #     url = link['src']
  #     next if url.nil?
  #
  #     absolute_url = URI.join(@url, url).to_s
  #     download_assets(absolute_url)
  #   end
  # end

  def get_absolution_url(resource_url)
    URI.join(@url, resource_url).to_s
  end
end