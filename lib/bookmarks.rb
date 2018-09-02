require 'pg'
require 'uri'

class Bookmarks

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    bookmarks = connection.exec("SELECT * FROM bookmarks")
    bookmarks.map do |bookmark|
      Bookmarks.new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url'])
    end
  end

  def self.create(url:, title:)
    return false unless is_url?(url)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES( '#{ url }', '#{title}' ) RETURNING id, title, url;")
    Bookmarks.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
