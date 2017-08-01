require "rails_helper"

RSpec.feature "Editing Exercises" do
  before do
    @john = User.create(email: "john@example.com", password: "password")

    @john_exercise = @john.exercises.create!(duration_in_min: 48,
                                             workout: "Exercício 1",
                                             workout_date: Date.today)

    login_as(@john)
  end

  scenario "with valid data succeeds" do
    visit "/"
    click_link "My Lounge"

    path = edit_user_exercise_path(@john, @john_exercise)
    link = "a[href=\'#{path}\']"

    find(link).click

    fill_in "Duration", with: 45
    click_button "Update Exercise"

    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(45)
    expect(page).not_to have_content(48)
  end
end
