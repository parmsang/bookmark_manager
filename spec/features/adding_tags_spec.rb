# /spec/features/adding_tags_spec.rb
feature 'Adding tags' do

  # scenario 'I can add a single tag to a new link' do
  #   visit '/links/new'
  #   fill_in 'url',   with: 'http://www.makersacademy.com/'
  #   fill_in 'title', with: 'Makers Academy'
  #
  #   fill_in 'tag',  with: 'education' # for now, let's input a single tag value.
  #   #later on we can go for multiple tags.
  #
  #   click_button 'Create link'
  #   link = Link.last
  #   expect(link.tags.map(&:name)).to include 'education'
  # end

  scenario 'I can add multiple tags to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    # our tags will be space separated
    fill_in 'tags',  with: 'education ruby'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end

end
