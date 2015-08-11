require "spec_helper"

feature "Viewing links" do

  scenario "I can see existing links on the links page" do
    link = Link.new(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    link.save
    visit "/links"
    expect(page.status_code).to eq 200
    within "ul#links" do
      expect(page).to have_content "Makers Academy"
    end
  end
end