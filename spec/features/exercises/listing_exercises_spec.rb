require "rails_helper"


RSpec.feature "Listing Exercises" do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    login_as(@john)

    @e1 = @john.exercises.create(duration_in_min: 20,
                                 workout: "Run",
                                 workout_date: Date.today)
    @e2 = @john.exercises.create(duration_in_min: 55,
                                 workout: "Run again",
                                 workout_date: 2.days.ago)
    @e3 = @john.exercises.create(duration_in_min: 120,
                                 workout: "Others",
                                 workout_date: 8.days.ago)
  end

  scenario "show user's workout for last 7 days" do
    visit "/"
    click_link "My Lounge"

    expect(page).to have_content(@e1.duration_in_min)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)

    expect(page).to have_content(@e2.duration_in_min)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)

    expect(page).not_to have_content(@e3.duration_in_min)
    expect(page).not_to have_content(@e3.workout)
    expect(page).not_to have_content(@e3.workout_date)

  end
end
