require "rails_helper"

RSpec.feature "Creating Exercises" do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    login_as(@john)

    visit "/"
    click_link "My Lounge"
    click_link "New Workout"

  end

  scenario "with valid inputs" do

    expect(page).to have_link("Back")

    fill_in "Duration", with: 70
    fill_in "Workout details", with: "Weight lifting"
    fill_in "Activity date", with: 3.days.ago
    click_button I18n.t("helpers.submit.create", model: Exercise)

    expect(page).to have_content("Exercise has been created")

    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@john, exercise))
    expect(exercise.user_id).to eq(@john.id)
  end

  scenario "with invalid inputs" do

    fill_in "Duration", with: "A"
    click_button "Create Exercise"

    expect(page).to have_content("Exercise has not been created")
    expect(page).to have_content I18n.t("errors.messages.blank")
    expect(page).to have_content I18n.t("errors.messages.not_a_number")
  end
end
