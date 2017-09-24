require "rails_helper"


RSpec.feature "Showing Friends Workout" do
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    @sarah = User.create(first_name: "Sarah", last_name: "Anderson", email: "sarah@example.com", password: "password")
    login_as(@john)

    @e1 = @john.exercises.create(duration_in_min: 20,
                                 workout: "Run",
                                 workout_date: Date.today)
    @e2 = @sarah.exercises.create(duration_in_min: 55,
                                 workout: "Run again",
                                 workout_date: 2.days.ago)

    @following = Friendship.create(user: @john, friend: @sarah)
  end

  scenario "show friend's workout for last 7 days" do
    visit "/"
    click_link "My Lounge"
    click_link @sarah.full_name

    expect(page).to have_content(@sarah.full_name)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_css("div#chart")
  end

  scenario "no exercises to list" do
    @john.exercises.delete_all

    visit "/"
    click_link "My Lounge"

    expect(page).to have_content("No Workouts Yet")
  end

  scenario "show a list of user's friends" do
    visit "/"
    click_link "My Lounge"

    expect(page).to have_content("My Friends")
    expect(page).to have_link(@sarah.full_name)
    expect(page).to have_link("Unfollow")
  end
end
