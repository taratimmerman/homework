# Screenshots on failure implementation
defmodule Homework.ScreenshotsOnFailure do
    # Test and take screenshot on failure.
    defmacro test_sof(message, var \\ quote do _ end, contents) do
        # Use test message for screenshot file name
        prefix = String.replace(message, ~r/\W+/, "-")
        filename = Hound.Utils.temp_file_path(prefix, "png")
        
        quote do
            test unquote(message), unquote(var) do
                try do
                    unquote(contents)
                catch
                    error ->
                        take_screenshot(unquote(filename))
                        raise error
                end
            end
        end
    end
end