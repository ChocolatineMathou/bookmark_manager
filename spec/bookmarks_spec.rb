require 'bookmarks'

describe Bookmarks do

  describe '.all' do
    it '.all returns a list of bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      Bookmarks.create(url: 'http://makers.tech/', title: 'Makers')
      Bookmarks.create(url: 'http://www.google.com', title: 'Google')

      bookmark = Bookmarks.all.first
      expect(bookmark).to respond_to(:id)
      expect(bookmark.title).to eq 'Makers'
      expect(bookmark.url).to eq 'http://makers.tech/'
    end
  end

  describe '.add' do
    it 'adds a new bookmark' do
      bookmark = Bookmarks.create(url: 'http://twitter.com', title: 'twitter homepage')
      expect(bookmark).to respond_to(:id)
      expect(bookmark.title).to eq 'twitter homepage'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      bookmark = Bookmarks.create(url: 'not a real bookmark', title: 'not url')
      expect(bookmark).not_to be_a Bookmarks
    end
  end

end
