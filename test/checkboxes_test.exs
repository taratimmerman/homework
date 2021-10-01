defmodule Homework.CheckboxesTest do
    # Import helpers
    use Hound.Helpers
    use ExUnit.Case
    # Screenshots on failure implementation
    import Homework.ScreenshotsOnFailure, only: [test_sof: 2]
        
    # Start hound session; destroy after tests run
    # This manages the session lifecycle for us
    hound_session()

    test_sof "checkboxes page should load as expected" do
        # Point browser to checkboxes example
        navigate_to "https://the-internet.herokuapp.com/checkboxes"

        # Second checkbox should be selected
        secondBox = find_element(:xpath, "//*[@id=\"checkboxes\"]/input[2]")
        assert selected?(secondBox)
    end

    test_sof "User can select and deselect checkboxes" do
        # Point browser to checkboxes example
        navigate_to "https://the-internet.herokuapp.com/checkboxes"

        # Select first checkbox
        firstBox = find_element(:xpath, "//*[@id=\"checkboxes\"]/input[1]")
        click(firstBox)
        assert selected?(firstBox)

        # Deselect second checkbox
        secondBox = find_element(:xpath, "//*[@id=\"checkboxes\"]/input[2]")
        click(secondBox)
        assert selected?(secondBox) == false
    end

    test_sof "State reverts to initial on page refresh" do
        # Point browser to checkboxes example
        navigate_to "https://the-internet.herokuapp.com/checkboxes"

        # Select first checkbox
        firstBox = find_element(:xpath, "//*[@id=\"checkboxes\"]/input[1]")
        click(firstBox)
        assert selected?(firstBox)

        # First box should not be selected on page refresh
        refresh_page()
        firstBox = find_element(:xpath, "//*[@id=\"checkboxes\"]/input[1]")
        assert selected?(firstBox) == false
    end
end