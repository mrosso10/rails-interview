require 'rails_helper'

describe 'CRUD todo lists' do
  before do
    driven_by :selenium_chrome_headless
  end

  describe 'create' do
    let(:list_name) { Faker::Lorem.sentence }
    it do
      visit '/todolists'
      click_on 'New todo list'
      fill_in 'todo_list_name', with: list_name
      click_on 'Save'
      expect(page).to have_text list_name
    end
  end

  describe 'destroy' do
    let(:todo_list) do
      create(:todo_list)
    end

    it do
      visit "/todolists/#{todo_list.id}"
      click_on 'Destroy this list'
      expect(page).to have_text 'Todo list was successfully destroyed.'
    end
  end
end
