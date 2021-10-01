defmodule Homework.FormAuthenticationTest do
        # Import helpers
        use Hound.Helpers
        use ExUnit.Case
        # Screenshots on failure implementation
        import Homework.ScreenshotsOnFailure, only: [test_sof: 2]
        
        # Start hound session; destroy after tests run
        # This manages the session lifecycle for us
        hound_session()

        test_sof "unauthenticated access is rejected" do
            # Point browser to secure area
            navigate_to "https://the-internet.herokuapp.com/secure"

            # Not logged in - browser should redirect to login page
            assert current_url() == "https://the-internet.herokuapp.com/login"

            # Must-login error should be visible
            error = find_element(:class, "error")
            assert visible_text(error) =~ "You must login to view the secure area!"
        end

        test_sof "invalid username yields error message" do
            # Point browser to form authentication example
            navigate_to "https://the-internet.herokuapp.com/login"

            # Select parent form
            form = find_element(:id, "login")

            # Input invalid username
            username = find_within_element(form, :id, "username")
            fill_field(username, "tara")
            assert attribute_value(username, "value") == "tara"

            # Submit form
            submit = find_within_element(form, :class, "radius")
            click(submit)

            # Invalid username error message should be visible
            error = find_element(:class, "error")
            assert visible_text(error) =~ "Your username is invalid!"
        end

        test_sof "invalid password yields error message" do
            # Point browser to form authentication example
            navigate_to "https://the-internet.herokuapp.com/login"

            # Input correct username (xpath strategy)
            username = find_element(:xpath, ~s|//*[@id="username"]|)
            fill_field(username, "tomsmith")
            assert attribute_value(username, "value") == "tomsmith"

            # Input invalid password (xpath strategy)
            password = find_element(:xpath, ~s|//*[@id="password"]|)
            fill_field(password, "getdivvy")
            assert attribute_value(password, "value") == "getdivvy"

            # Submit form (xpath strategy)
            submit = find_element(:xpath, ~s|//*[@class="radius"]|)
            click(submit)

            # Invalid password error message should be visible (xpath strategy)
            error = find_element(:xpath, ~s|//*[@id="flash"]|)
            assert visible_text(error) =~ "Your password is invalid!"
        end

        test_sof "valid inputs yield successful login and message" do
            # Point browser to form authentication example
            navigate_to "https://the-internet.herokuapp.com/login"

            # Select parent form
            form = find_element(:id, "login")

            # Input correct username
            username = find_within_element(form, :id, "username")
            fill_field(username, "tomsmith")
            assert attribute_value(username, "value") == "tomsmith"

            # Input correct password
            password = find_within_element(form, :id, "password")
            fill_field(password, "SuperSecretPassword!")
            assert attribute_value(password, "value") == "SuperSecretPassword!"

            # Submit form (directly passing the selector as a tuple)
            click({:class, "radius"})

            # Success message should be visible
            success = find_element(:class, "success")
            assert visible_text(success) =~ "You logged into a secure area!"

            # Confirm secure area
            assert current_url() == "https://the-internet.herokuapp.com/secure"
        end
end