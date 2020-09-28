require "application_system_test_case"

module Components
  module Student
    class TrackListTest < ApplicationSystemTestCase
      include TableMatchers

      test "shows tracks" do
        track = create :track, title: "Ruby"
        user = create :user
        concept_exercises = Array.new(10).map { create :concept_exercise, track: track }
        practice_exercises = Array.new(10).map { create :practice_exercise, track: track }
        create :user_track, track: track, user: user
        concept_exercises.sample(5).map { |ex| create :concept_solution, user: user, exercise: ex }
        practice_exercises.sample(5).map { |ex| create :practice_solution, user: user, exercise: ex }

        visit test_components_student_track_list_url

        row = {
          "Icon" => lambda {
            assert_css "img[src='https://assets.exercism.io/tracks/ruby-hex-white.png'][alt='icon for Ruby track']"
          },
          "Title" => "Ruby",
          "Num concept exercises" => 10,
          "Num practice exercises" => 10,
          "URL" => "https://test.exercism.io/tracks/ruby",
          "New?" => "true",
          "Tags" => "OOP, Web Dev",
          "Joined?" => "true",
          "Num completed concept exercises" => 5,
          "Num completed practice exercises" => 5
        }
        assert_table_row first("table"), row
      end
    end
  end
end