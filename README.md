# VLC Mark In/Out and Create Clip Extension

This VLC extension allows users to mark in and out points in a video and create a video clip using `ffmpeg`. The extension provides a simple interface to set the start and end points and automatically generates an `ffmpeg` command to create a video clip using the user-defined time range. The latest update also includes a feature that populates an input field with the generated `ffmpeg` command for easy copying.

## Features

- Set mark in and out points in a video.
- Generates an `ffmpeg` command to create a clip with the marked time range.
- Populates an input field with the `ffmpeg` command for easy use.
- Allows copying of the `ffmpeg` command for manual processing.
- Requires `ffmpeg` for video processing.

## Requirements

- VLC Media Player (version 3.0.0 or higher).
- ffmpeg (version 4.0 or higher).

## Installation

1. Download the `mark_in_out.lua` file from this repository.
2. Place the `mark_in_out.lua` file in the VLC extensions directory:
   - Windows: `%APPDATA%\vlc\lua\extensions\`
   - macOS: `~/Library/Application Support/org.videolan.vlc/lua/extensions/`
   - Linux: `~/.local/share/vlc/lua/extensions/`
3. Restart VLC Media Player.
4. Enable the extension by going to `View` > `Mark In/Out and Create Clip (Extension)` in the VLC menu.

## Usage

1. Open a video file in VLC Media Player.
2. Enable the extension by going to `View` > `Mark In/Out and Create Clip (Extension)` in the VLC menu.
3. Play the video and click the "Mark In" button to set the start point of the clip.
4. Click the "Mark Out" button to set the end point of the clip, or use the "Create at End" button to automatically set the mark out point at the end of the video.
5. The `ffmpeg` command will be generated and displayed in an input field within the extension dialog. You can copy this command to create the video clip manually using `ffmpeg` in your preferred terminal or command prompt.

The extension will create an `ffmpeg` command to produce a video clip in the same directory as the original video file. The output file will be named following the format `<original_filename>_c.<extension>`.

## Troubleshooting

If you encounter any issues, check the debug log in VLC by going to `Tools` > `Messages` and set the verbosity level to 2 (debug). This will provide detailed information about the extension's operation and any errors that may have occurred.

## License

This project is released under the [MIT License](LICENSE).

## Acknowledgements

This VLC extension was created using the [OpenAI GPT-4 model](https://openai.com/research/), an advanced language model capable of understanding and generating human-like text.
