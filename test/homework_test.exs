defmodule HomeworkTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case

  # Screenshots on failure implementation
  import Homework.ScreenshotsOnFailure, only: [test_sof: 2]

  # Start hound session and destroy when tests are run
  hound_session()

  test_sof "landing page loads correctly" do
    # Point browser to the-internet
    navigate_to "https://the-internet.herokuapp.com/"

    # Page title should be correct
    assert page_title() =~ "The Internet"

    # Example message should be visible
    examplesTitle = find_element(:tag, "h2")
    assert visible_text(examplesTitle) == "Available Examples"

    # Should be at least 3 available examples
    examples = find_all_elements(:tag, "li")
    exampleAmount = Enum.count(examples)
    assert exampleAmount >= 3
  end
end
