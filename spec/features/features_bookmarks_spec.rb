feature 'Bookmarks features' do

  scenario 'homepage displays welcome message' do
    visit('/')
    expect(page).to have_content('Welcome')
  end

  scenario 'a user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    Bookmarks.create(url: 'http://www.makers.tech', title: 'Makers')
    Bookmarks.create(url: 'http://www.google.com', title: 'Google')

    visit('/bookmarks')
    expect(page).to have_link('Makers', href: 'http://www.makers.tech')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end

  scenario 'a user can bookmark a page' do
    visit('/add_bookmark')
    fill_in('url', with: 'http://www.franceinter.fr')
    fill_in('title', with: 'France Inter')
    click_button 'Submit'
    expect(page).to have_link('France Inter', href: 'http://www.franceinter.fr')
  end



end
