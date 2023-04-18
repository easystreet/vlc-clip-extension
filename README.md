# VLC Mark In/Out and Create Clip Extension

This VLC extension allows users to mark in and out points in a video and create a video clip using `ffmpeg`. The extension provides a simple interface to set the start and end points and automatically generates a video clip using the user-defined time range.

## Features

- Set mark in and out points in a video
- Automatically create a video clip using the marked time range
- Requires `ffmpeg` for video processing

## Requirements

- VLC Media Player (version 3.0.0 or higher)
- ffmpeg (version 4.0 or higher)

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
3. Play the video and click the "Mark In" button when you want to set the start point of the clip.
4. Click the "Mark Out" button when you want to set the end point of the clip.
5. Click the "Create Clip" button to generate a video clip using the marked time range.

The extension will use `ffmpeg` to create a video clip in the same directory as the original video file. The output file will be named in the format `clip_<mark_in>_<mark_out>.mp4`.

## Troubleshooting

If you encounter any issues, check the debug log in VLC by going to `Tools` > `Messages` and set the verbosity level to 2 (debug). This will provide detailed information about the extension's operation and any errors that may have occurred.

## License

This project is released under the [MIT License](LICENSE).

## Acknowledgements

This VLC extension was created using the [OpenAI GPT-4 model](https://openai.com/research/), an advanced language model capable of understanding and generating human-like text.
