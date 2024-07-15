# Laboratorio 21/22

<br/>
<p align="center">
  <a href="https://github.com/codemonsters/racekombat">
    <img src="https://github.com/codemonsters/racekombat/blob/main/server/assets/logo.png?raw=true" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Codemonsters RaceKombat</h3>

  <p align="center">
    <a href="https://github.com/codemonsters/racekombat/issues">Report Bug</a>
    .
    <a href="https://github.com/codemonsters/racekombat/issues">Request Feature</a>
  </p>
</p>

![Downloads](https://img.shields.io/github/downloads/codemonsters/racekombat/total) ![Contributors](https://img.shields.io/github/contributors/codemonsters/racekombat?color=dark-green) ![Stargazers](https://img.shields.io/github/stars/codemonsters/racekombat?style=social) ![Issues](https://img.shields.io/github/issues/codemonsters/racekombat) ![License](https://img.shields.io/github/license/codemonsters/racekombat)

<p align="center>
  <a href="https://play.google.com/store/apps/details?id=org.godotengine.racekombatclient">
    <img src="google-play-badge.png" height="50">
  </a>
  <br>
  <br>
  <a href="https://github.com/codemonsters/racekombat/releases/latest">
    <img src="https://img.shields.io/github/v/release/codemonsters/racekombat?include_prereleases&style=for-the-badge&logoColor=blue&label=Download%20here!&color=blue">
  </a>
</p>

## Table Of Contents

- [About the Project](#about-the-project)
- [Built With](#built-with)
- [Getting Started](#getting-started)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)
- [Other](#other)

## About The Project

![Screen Shot](https://github.com/codemonsters/racekombat/blob/main/showcase.png?raw=true)

RaceKombat is a 2D platformer game where you can play against your friends in a chaotic multiplayer race. The game is built with Godot Engine, and is available for Windows, Linux and MacOS. You will need the server running on your PC (available in the [releases](https://github.com/codemonsters/racekombat/releases/latest)) and can optionally use your phone as a gamepad to play the game by downloading the gamepad client from the [Play Store](https://play.google.com/store/apps/details?id=org.godotengine.racekombatclient) (not available for iOS unfortunately).

The game is built for the Codemonsters community, and is open-source. You can contribute to the project by adding new features, fixing bugs, or improving the game in any way you want.

## Built With

Godot Engine

## Getting Started

Download the pre-built executables from releases, and you are ready to go! You can also download the repo and run it from Godot Engine

## Roadmap

See the [open issues](https://github.com/codemonsters/racekombat/issues) for a list of proposed features (and known issues).

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are greatly appreciated.

- If you have suggestions for adding or removing projects, feel free to open an issue to discuss it, or directly create a pull request after you edit the README.md file with necessary changes.
- Create individual PR for each suggestion.

## License

Lorem Ipsum

## Acknowledgements

- [ShaanCoding](https://github.com/ShaanCoding/)
- [Othneil Drew](https://github.com/othneildrew/Best-README-Template)
- [ImgShields](https://shields.io/)
- [ACB-prgm](https://github.com/ACB-prgm) - _Gamepad client_
- [Shaan Khan](https://github.com/ShaanCoding/) - _Built ReadME Template_

## Other:

- [Invitación al servidor de Discord para la actividad de Laboratorio.](https://discord.gg/ZQaNtRF)

## HOW-TO Configure vscode with godot-engine

Para abrir los scripts con VS Code, y no con godot, hay que hacer esto:

- En Godot ir a `Editor>Configuración del editor`
- Ir a `Text Editor > External`
- Activar `Editor externo`
- En exec path poner la ruta al archivo `code.cmd`
- A continuación, poner `{project} --goto {file}:{line}:{col}`.

Finalmente, instalar el plugin godot tools en VS Code.

¡Y ya está! ¡Puedes considerarte un genio!</p>

### 2nd method (Mejor)

1. Abre el directorio del projecto en vscode.
2. Instala godot-tools.
3. Averigua el path a tu ejecutable godot.
4. En las preferencias de godot-tools, añade el path.
5. Reinicia vscode, y al abrir un directorio godot, en el popup que sale, dále a `Open Godot Editor`

## Removing git commit username

- Para actualizar el url de origin con un nuevo nombre de usuario:

  1- Entrar en el archivo `.gitconfig` y eliminas user.

  2- En Windows:

  `Step 1: Open Control panel. `

  `Step 2: Click on Credential Manager.`

  `Step 3: Click on Windows Credentials under Manage your credentials page.`

  `Step 4: Under Generic Credentials click on github.`

  `Step 5: Click on Remove and then confirm by clicking Yes button.`

  3- En Linux:

  `git config --global --unset-all`

## iOS notes

NOTE: Godot Engine v3.4.3 breaks iOS multitouch, use earlier versions or v3.4.4 RC1 onwards.

### Godot iOS export

You will need a computer running MacOS to do this

1. Choose any Team ID. (Ex. `1234`)
2. Choose Identifier. (Ex. `es.codemonsters.racekombat.gamepad`)
3. Choose Required Icons.
4. Export Project to an empty folder.

### How to build unsigned `.ipa` without developer account

1. Open terminal, go to your project directory.
2. Run this command: `xcodebuild -scheme YOUR_SCHEME -archivePath archived.xcarchive CODE_SIGNING_ALLOWED=NO` - replace YOUR_SCHEME with your scheme (target/app name, or run `xcodebuild -list` if unsure; `-ArchivePath` is optional, as it refused to export to the indicated path.)
3. Then just go into `archived.xcarchive/Products/Applications`. Your .app will be there. (In my case, `~/Library/Developer/Xcode/DerivedData/appname-gibberish/Build/Products/Debug-iphoneos/appname.app`)
   Make a new folder called Payload, drop your .app into it. Zip it, and rename it to .ipa.
4. Yes, really.

[Source](https://www.reddit.com/r/jailbreakdevelopers/comments/gj93vc/question_exporting_app_in_xcode_without_a/)

[Rudimentary script for building unsigned .ipa for this project](https://gist.github.com/Autotren/6c6311dccea3e7d4dba6d7d52f242e59)

### How to install app

- Without developer account, I recommend using [AltStore](https://altstore.io) with the `.ipa` made with the method above. This has the advantage of being able to renew the 7-day free certificate automatically.
- Otherwise, just open the generated xcode project and build it directly with your Apple device as target. This way will force you to redo this through xcode after 7 days.

## Android notes

- The app needs the `Internet` permission when exporting through godot to connect.
- For general setup, [read here](https://developer.android.com/games/engines/godot/godot-configure).
