require 'rails_helper'

describe 'CRUD todo lists' do
  before do
    driven_by :selenium_chrome
  end

  describe 'create' do
    it do
      visit '/todolists'
      click_on 'New todo list'
      fill_in 'todo_list_name', with: Faker::Lorem.sentence
      click_on 'Save'
      expect(page).to have_text 'Add item'
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
