function descriptor()
    return {
        title = "Mark In/Out and Create Clip (Extension)";
        version = "1.0";
        author = "Your Name";
        url = "http://your-url";
        shortdesc = "Mark In/Out and Create Clip (Extension)";
        description = "Mark in and out points in a video and create a clip using ffmpeg";
    }
  end
  
  local mark_in = nil
  local mark_out = nil
  
  function activate()
    create_dialog()
  end
  
  function deactivate()
  end
  
  function meta_changed()
  end
  
  function create_dialog()
    local dlg = vlc.dialog("Mark In/Out and Create Clip")
  
    local mark_in_label = dlg:add_label("Mark In: -", 1, 1, 1, 1)
    dlg:add_button("Mark In", function()
      local input = vlc.object.input()
      if not input then return end
  
      local current_time = vlc.var.get(input, "time")
      mark_in = current_time
      mark_in_label:set_text("Mark In: " .. string.format("%.6f", mark_in) .. " seconds")
  end, 2, 1, 1, 1)
  
    local mark_out_label = dlg:add_label("Mark Out: -", 3, 1, 1, 1)
    dlg:add_button("Mark Out", function()
      local input = vlc.object.input()
      if not input then return end
  
      local current_time = vlc.var.get(input, "time")
      mark_out = current_time
      mark_out_label:set_text("Mark Out: " .. string.format("%.6f", mark_out) .. " seconds")
  end, 4, 1, 1, 1)
  
  dlg:add_button("Create Clip", function()
    if mark_in and mark_out then
        local input = vlc.object.input()
        if not input then return end
  
        local input_uri = vlc.input.item():uri()
        local input_path = vlc.strings.decode_uri(input_uri):gsub("file:///", "")
  
        local mark_in_formatted = string.format("%02d:%02d:%06.3f", math.floor(mark_in / 3600), math.floor(mark_in / 60) % 60, mark_in % 60)
        local duration = mark_out - mark_in
        local duration_formatted = string.format("%02d:%02d:%06.3f", math.floor(duration / 3600), math.floor(duration / 60) % 60, duration % 60)f
  
          local output_filename = "clip_" .. mark_in .. "_" .. mark_out .. ".mp4"
  
          local command = string.format('ffmpeg -y -i "%s" -ss %s -t %s -c copy "%s"', input_path, mark_in_formatted, duration_formatted, output_filename)
  
            vlc.msg.dbg("Executing command: " .. command)
  
            local log_file = "ffmpeg_log.txt"
            local command_with_logging = command .. " >" .. log_file .. " 2>&1"
            os.execute(command_with_logging)
  
            vlc.msg.dbg("Clip created: " .. output_filename)
        else
            vlc.msg.dbg("Both Mark In and Mark Out must be set")
        end
    end, 1, 2, 4, 1)
  
    dlg:show()
  end
  
  