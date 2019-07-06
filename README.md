# Bash-savesystemconf

Simple tool for saving host-specific system-wide configuration to a timestamped bz2 archive.

*Note: I use this script for my own projects, it contains only the features I need.*

## Table of Contents

[Installation](#installation) | [Features](#features) | [Test](#test) | [Contributing](#contributing) | [License](#license)

## Installation

Requires: a Debian/Ubuntu version of linux and a Bash version ~4.4. [bash-sys](https://github.com/ojullien/bash-sys) installed.

1. [Download a release](https://github.com/ojullien/bash-savesystemconf/releases) or clone this repository.
2. Use [scripts/install.sh](scripts/install.sh) to automatically install the application in the /opt/oju/bash project folder.
3. If needed, add `PATH="$PATH:/opt/oju/bash/bin"` to the .profile files.
4. Update the [config.sh](src/app/savesystemconf/config.sh) configuration file.

## Features

This tool allows you to save a system conf directory, located in /etc/, to a timestamped bz2 archive. The destination is defined in the [config.sh](src/app/savesystemconf/config.sh) file.

```bash
Usage: savesystemconf.sh [options] <directory 1> [directory 2 ...]

  <directory 1>   Configuration directory name located in /etc/

options
  -d | --destination    Destination folder. The default is /home/<user>
  -n | --no-display     Display mode. Nothing is displayed in terminal.
  -l | --active-log     Log mode. Content outputs are logged in a file.
  -w | --wait           Wait user. Wait for user input between actions.
  -h | --help           Show this help.
  -v | --version        Show the version.
```

## Test

I didn't write any line of 'unit test' code. Sorry.

## Contributing

Thanks you for taking the time to contribute. Please fork the repository and make changes as you'd like.

As I use these scripts for my own projects, they contain only the features I need. But If you have any ideas, just open an [issue](https://github.com/ojullien/bash-savesystemconf/issues/new/choose) and tell me what you think. Pull requests are also warmly welcome.

If you encounter any **bugs**, please open an [issue](https://github.com/ojullien/bash-savesystemconf/issues/new/choose).

Be sure to include a title and clear description,as much relevant information as possible, and a code sample or an executable test case demonstrating the expected behavior that is not occurring.

## License

This project is open-source and is licensed under the [MIT License](LICENSE).
