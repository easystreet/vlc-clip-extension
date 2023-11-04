function descriptor()
  return {
      title = "Mark In/Out and Create Clip (Extension)",
      version = "1.0",
      author = "Your Name",
      url = "http://your-url",
      shortdesc = "Mark In/Out and Create Clip (Extension)",
      description = "Mark in and out points in a video and create a clip using ffmpeg"
  }
end

local mark_in = nil
local mark_out = nil
local input_file_path = nil -- Variable to store the file path when Mark In is clicked
local command_input -- Variable to store the command input field

function activate()
  create_dialog()
end

function deactivate()
end

function close()
  -- Perform any necessary cleanup here
  vlc.msg.dbg("Dialog closed")
end

function meta_changed()
end

function create_dialog()
  vlc.msg.dbg("Dialog created")
  local dlg = vlc.dialog("Mark In/Out and Create Clip")

  -- Labels and buttons
  local mark_in_label = dlg:add_label("Mark In: -", 1, 1, 1, 1)
  local mark_out_label = dlg:add_label("Mark Out: -", 3, 1, 1, 1)

  -- Add a text input to display the ffmpeg command
  command_input = dlg:add_text_input("", 1, 5, 4, 1)

  -- Button to mark the in point
  dlg:add_button("Mark In", function()
      local input = vlc.object.input()
      if not input then
          return
      end

      local current_time = vlc.var.get(input, "time") / 1000000
      mark_in = current_time
      local mark_in_formatted = string.format("%02d:%02d:%06.3f", math.floor(mark_in / 3600),
          math.floor(mark_in / 60) % 60, mark_in % 60)
      mark_in_label:set_text("Mark In: " .. mark_in_formatted)

      -- Store the file path when "Mark In" is clicked
      local input_item = vlc.input.item()
      if input_item then
          local input_uri = input_item:uri()
          if input_uri then
              input_file_path = vlc.strings.decode_uri(input_uri):gsub("file:///", "")
          end
      end
      if not input_file_path then
          vlc.msg.dbg("Failed to retrieve the file path for the current input.")
      end
  end, 2, 1, 1, 1)

  -- Button to mark the out point
  dlg:add_button("Mark Out", function()
      local input = vlc.object.input()
      if not input then
          return
      end

      local current_time = vlc.var.get(input, "time") / 1000000
      mark_out = current_time
      local mark_out_formatted = string.format("%02d:%02d:%06.3f", math.floor(mark_out / 3600),
          math.floor(mark_out / 60) % 60, mark_out % 60)
      mark_out_label:set_text("Mark Out: " .. mark_out_formatted)
  end, 4, 1, 1, 1)

  -- Button to create a clip with the marked in/out points
  dlg:add_button("Create Clip", function()
      if mark_in and mark_out and input_file_path then -- Check if input_file_path is not nil
          local input_filename = input_file_path:match("(.+)%..+$")
          local input_extension = input_file_path:match("^.+(%..+)$")

          local mark_in_formatted = string.format("%02d:%02d:%06.3f", math.floor(mark_in / 3600),
              math.floor(mark_in / 60) % 60, mark_in % 60)
          local duration = mark_out - mark_in
          local duration_formatted = string.format("%02d:%02d:%06.3f", math.floor(duration / 3600),
              math.floor(duration / 60) % 60, duration % 60)

          local output_filename = input_filename .. "_c" .. input_extension

          local command = string.format('ffmpeg -y -i "%s" -ss %s -t %s -c copy "%s"', input_file_path,
              mark_in_formatted, duration_formatted, output_filename)
          vlc.msg.warn("---------------")
          vlc.msg.warn(" ")
          vlc.msg.warn(command)
          vlc.msg.warn(" ")
          vlc.msg.warn("---------------")

          -- Update the command text input with the generated command
          command_input:set_text(command)
      else
          vlc.msg.dbg("Both Mark In and Mark Out must be set and a file must be selected")
      end
  end, 1, 2, 4, 1)

  -- Button to create a clip with the marked in point and the end of the video
  dlg:add_button("Create at End", function()
      if mark_in and input_file_path then
          local input = vlc.object.input()
          if not input then
              vlc.msg.dbg("No input found.")
              return
          end

          -- Get the duration of the current video to use as mark out
          local input_length = vlc.input.item():duration()
          mark_out = input_length

          local input_filename = input_file_path:match("(.+)%..+$")
          local input_extension = input_file_path:match("^.+(%..+)$")
          local mark_in_formatted = string.format("%02d:%02d:%06.3f", math.floor(mark_in / 3600),
              math.floor(mark_in / 60) % 60, mark_in % 60)
          local duration = mark_out - mark_in
          local duration_formatted = string.format("%02d:%02d:%06.3f", math.floor(duration / 3600),
              math.floor(duration / 60) % 60, duration % 60)
          local output_filename = input_filename .. "_c" .. input_extension
          local command = string.format('ffmpeg -y -i "%s" -ss %s -t %s -c copy "%s"', input_file_path,
              mark_in_formatted, duration_formatted, output_filename)

          vlc.msg.warn("---------------")
          vlc.msg.warn(" ")
          vlc.msg.warn(command)
          vlc.msg.warn(" ")
          vlc.msg.warn("---------------")
          -- Update the command text input with the generated command
          command_input:set_text(command)
      else
          vlc.msg.dbg("Mark In must be set and a file must be selected")
      end
  end, 1, 3, 4, 1)

  dlg:show()
end
