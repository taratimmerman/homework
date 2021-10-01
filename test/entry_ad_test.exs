defmodule Homework.EntryAdTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case
  # Screenshots on failure implementation
  import Homework.ScreenshotsOnFailure, only: [test_sof: 2]

  # Start hound session; destroy after tests run
  # This manages the session lifecycle for us
  hound_session()

  test_sof "modal window should be visible on page load" do
    # Point browser to entry ad example
    navigate_to "https://the-internet.herokuapp.com/entry_ad"

    # Modal window should be visible
    :timer.sleep(500)
    assert element_displayed?({:class, "modal"})

    # Modal window state persists on page refresh
    refresh_page()
    :timer.sleep(1000)
    assert element_displayed?({:class, "modal"})
  end

  test_sof "modal window should not be visible on close" do
    # Point browser to entry ad example
    navigate_to "https://the-internet.herokuapp.com/entry_ad"

    # Modal window should be visible
    modal = find_element(:class, "modal")
    :timer.sleep(500)
    assert element_displayed?(modal)

    # User can close modal window
    close = find_within_element(modal, :tag, "p")
    click(close)

    # Modal window is no longer visible
    refresh_page()
    assert element_displayed?({:class, "modal"}) == false
  end
end
