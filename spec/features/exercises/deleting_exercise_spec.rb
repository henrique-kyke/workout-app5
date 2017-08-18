require "rails_helper"

RSpec.feature "Deleting Exercises" do
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")

    @john_exercise = @john.exercises.create!(duration_in_min: 48,
                                             workout: "Exercício 1",
                                             workout_date: Date.today)

    login_as(@john)
  end

  scenario do
    visit "/"
    click_link "My Lounge"

    path = "/users/#{@john.id}/exercises/#{@john_exercise.id}"
    link = "//a[contains(@href,\'#{path}\') and .//text()='Delete']"

    find(:xpath, link).click

    expect(page).to have_content("Exercise has been deleted")
  end
end
