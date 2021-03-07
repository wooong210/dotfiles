# Mac Setting

## Backup

## Format

- 포맷용 USB 만들기

```shell
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
```

## Re-Install

### Initial Setting

- 클린한 사용을 위해 English(United States)로 MacOS 설치

- Homebrew 설치

  ```shell
  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  ```

- iterm2 설치

  ```shell
  brew cask install iterm2
  ```

  - Preferences > Appearance > Windows > Hide scrollbars : Enable
  - Preferences > Appearance > Windows > Show line under title bar when the tab bar is not visible : Disable
  - Preferences > Keys > Hotkey > Create a Dedicated Hotkey Window.. > Click : Command + Shift + x

- 포맷 직후 재설정을 원활히 하기 위하여

  - System Preference > Trackpad > Tab to Click : Enable
  - System Preference > Accessibility > Pointer Control > Trackpad Options.. > Enable dragging : three finger drag
  - System Preference > Language & Region > Preferred languages : 한국어 추가 (English Primary 유지)
  - System Preference > Keyboard > Use F1, F2, etc. keys as standard function keys
  - System Preference > Keyboard > Text : Remove all items in list
  - System Preference > Keyboard > Text > Correct spelling automatically : Disable
  - System Preference > Keyboard > Text > Capitalize words automatically : Disable
  - System Preference > Keyboard > Text > Add period with double-space : Disable
  - System Preference > Keyboard > Text > Use smart quotes and dashes : Disable

- Mac App Store에 로그인

- `.env` 수정

- `setup.sh` 실행

### Preferences

- 시스템 및 기본 앱 설정

  - System Preference > Dock > Show recent applications in Dock : Disable
  - System Preference > Mission Control > Automatically rearrange Spaces based on most recent use : Disable
  - System Preference > Security & Privacy > Show a message when the screen is locked : Enable & Set Lock Message
  - System Preference > Bluetooth > Show Bluetooth in menu bar : Enable
  - System Preference > Sound > Show volume in menu bar : Enable
  - Finder > Preferences > Show these items on the desktop > Hard disks : Enable
  - Finder > Preferences > New Finder windows show : Home Folder
  - Finder > Preferences > Sidebar : Enable User Home (Disable Recents / Enable Pictures
  - Finder > Preferences > Advanced > Show all filename extensions : Enable
  - Finder > Preferences > Advanced > When performing a search : Search the Current Folder
  - Notes > Edit > Spelling and Grammar > Correct Spelling Automatically : Disable

- 키 누르고 있을 때 연속 입력

  ```shell
  defaults write -g ApplePressAndHoldEnabled -bool false
  ```

- 바탕 화면 파일 보이는거 지우기

  ```shell
  defaults write com.apple.finder CreateDesktop -bool false && killall Finder
  ```

- 숨김 파일 보이기

  ```shell
  defaults write com.apple.finder AppleShowAllFiles -bool YES && killall Finder
  ```

- Library 폴더 보이기

  ```shell
  chflags nohidden ~/Library/
  ```

- Screenshot 저장 위치 변경

  ```shell
  defaults write com.apple.screencapture location /path/;killall SystemUIServer
  defaults write com.apple.screencapture location ~/Desktop && killall SystemUIServer
  ```

- iTerm2 Font change

  - Preference > Profiles > Text > Font : MesloLGS NF

- Karabiner-Elements 설정

  - ~/.config/karabiner/assets/complex_modifications에 Karabiner_KorEng.json 복사

### Mac App Store

- 유료 앱 (따로 결제 필요)

  ```shell
  mas install 634148309 # Logic Pro
  mas install 424390742 # Compressor
  mas install 424389933 # Final Cut Pro
  mas install 434290957 # Motion
  mas install 462058435 # Microsoft Excel
  mas install 462062816 # Microsoft Powerpoint
  mas install 462054704 # Microsoft Word
  ```
