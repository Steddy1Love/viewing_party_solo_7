require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: "Tarzan", email: 'tarzan113@email.com', password: "hunter8")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    within '.login_form' do
      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Log In"
    end

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in with bad credentials" do
    user = User.create(name: "Tarzan", email: 'tarzan113@email.com', password: "hunter8")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    within '.login_form' do
      fill_in :email, with: user.email
      fill_in :password, with: 'wrong password'

      click_on "Log In"
    end

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Invalid email address or password.")
  end
end