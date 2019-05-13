require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit new_url
    assert_selector "h1", text: "Game"
  end
end
