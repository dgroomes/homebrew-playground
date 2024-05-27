# homebrew-playground

📚 Learning and exploring Homebrew (macOS package manager).


## Overview

Homebrew is super effective for helping you manage the installations and upgrades of the many tools you depend on as a
developer. I've used it for years. Now I want to learn how to write my own Homebrew package definitions (i.e. formulas)
so that I can still get the advantages of Homebrew for tools that aren't in the Homebrew repository and for which I am
able and willing to manage my own formulas.

Let's learn Homebrew by defining a "hello world"-style formula and following through the process of **installation**,
**upgrades**, and **uninstallation**.

Notice the file `hello-world.zsh` in the root of the project. This acts as the "managed package" (or I might refer to it
as just "software") that we are interested in installing onto our machine by using a Homebrew formula. This is a trivial
example. Normally the software you want to install is hosted remotely and involves more files, dependencies and
installation steps.

This repository is also designed as a "formula repository". This means it has a `Formula/` directory. In our case, it
only contains one formula file—`hello-world.rb`—which defines the formula `hello-world`. Formula repositories are
"tapped" by Homebrew installations. We're going to tap this repository and install the `hello-world` formula in the
example below.


## Instructions

Follow these steps to run through the example.

1. "Tap" this repository into Homebrew
   * ```shell
     brew tap dgroomes/homebrew-playground "$PWD"
     ``` 
   * The command output will look similar to the following.
   * ```text
     $ brew tap dgroomes/homebrew-playground "$PWD"
     ==> Tapping dgroomes/playground
     Cloning into '/opt/homebrew/Library/Taps/dgroomes/homebrew-playground'...
     done.
     Tapped 1 formula (22 files, 17.9KB).
     ```
   * Usually we tap formula repositories from GitHub, and we name the tap using the GitHub owner/repository name. That's
     why I chose the name `dgroomes/homebrew-playground`. But for this example, we actually tapped a local Git
     repository and so the name is arbitrary.
2. Install the formula
   * ```shell
     brew install dgroomes/homebrew-playground/hello-world
     ```
   * The output looks like the following on my computer.
   * ```text
      $ brew install dgroomes/homebrew-playground/hello-world
      ==> Fetching dgroomes/playground/hello-world
      ==> Downloading file:///Users/dave/repos/personal/homebrew-playground/hello-world.zsh
      ######################################################################################################################################################################################################################################################### 100.0%
      ==> Installing hello-world from dgroomes/playground
      🍺  /opt/homebrew/Cellar/hello-world/1.0.0: 4 files, 4.2KB, built in 0 seconds
     ```
3. Use the command
   * ```shell
     hello-world
     ```
   * The output is as expected.
   * ```text
     Hello, World!
     ```
   * Trace the `hello-world` command back to the `hello-world.zsh` file by using `which`. The command and output will look like the
     following.
   * ```text
     $ which hello-world
     /opt/homebrew/bin/hello-world
     ```
4. Edit the formula
   * Imagine we want to add a new feature to the formula and release it as a new version. We can edit the formula file
     directly with `brew edit`. This opens the formula file in a text editor. Try this now.
   * ```shell
     brew edit dgroomes/homebrew-playground/hello-world
     ```
   * Change the version to `1.0.1` and edit the description (add an exclamation point inside the 'hello world' quoted
     text). Next, we'll do an "audit" to help ensure our formula is in good shape. 
5. Audit the formula.
   * ```shell
     brew audit --formula dgroomes/homebrew-playground/hello-world
     ```
   * This is really useful for catching problems with the formula and getting useful feedback, like if the checksum
     (`sha256`) is missing.
6. Upgrade the formula
   * ```shell
     brew upgrade dgroomes/homebrew-playground/hello-world 
     ```
   * The output looks like the following on my computer.
   * ```text
     $ brew upgrade dgroomes/homebrew-playground/hello-world 
     ==> Upgrading 1 outdated package:
     dgroomes/playground/hello-world 1.0.0 -> 1.0.1
     ==> Fetching dgroomes/playground/hello-world
     ==> Downloading file:///opt/homebrew/Library/Taps/dgroomes/homebrew-playground/hello-world.zsh
     Already downloaded: /Users/dave/Library/Caches/Homebrew/downloads/b96bc45084caab2acce33d8c6180e8200302b0b802a8a032adfca62fe43851e8--hello-world.zsh
     ==> Upgrading dgroomes/playground/hello-world
     1.0.0 -> 1.0.1
     🍺  /opt/homebrew/Cellar/hello-world/1.0.1: 4 files, 4.8KB, built in 0 seconds
     ```
7. Run the formula test
   * ```shell
     brew test dgroomes/homebrew-playground/hello-world
     ```
   * The formula defines a `test` block. This a useful way to test the installation of a formula. A test case also
     serves as a basic example of how to use the software installed by the formula.
8. Uninstall the formula.
   * ```shell
     brew uninstall dgroomes/homebrew-playground/hello-world
     ```
   * The output looks like the following on my computer.
   * ```text
     $ brew uninstall dgroomes/homebrew-playground/hello-world
     Uninstalling /opt/homebrew/Cellar/hello-world/1.0.1... (4 files, 4.8KB)
     ```
9. Untap the repository.
   * ```shell
     brew untap dgroomes/homebrew-playground
     ```
   * The output looks like the following on my computer.
   * ```text
     $ brew untap dgroomes/homebrew-playground
     Untapping dgroomes/playground...
     Untapped 1 formula (39 files, 31.6KB).
     ```


## Wish List
General clean-ups, TODOs and things I wish to implement for this project:

* [x] DONE Custom formula for a simple tool, like a "Hello, World!" Zsh script.
* [x] DONE Uninstall
* [x] DONE Test
* [x] DONE Upgrade
* [ ] Can I turn on more debug info in Homebrew? For example, my test block either isn't getting run or I did something
  else wrong. I purposely wrote it to fail but I'm seeing no output. The install works and the `test` command works.
* [x] DONE Consider putting `hello-world.rb` in `Formula/` and treating `homebrew-playground` as a proper formula repository.
  Homebrew makes the `--no-git` thing awkward because it generates even a `.github` directory. Very GitHub-centric.
* [ ] Note the philosophy of formulas. Homebrew makes a source vs bottle distinction. But Adoptium's OpenJDK
  distribution (Eclipse Temurin) is a binary and not quite a bottle (do you have to package it in a specific
  "Homebrew way" to be a bottle? I hope not, then I'm happy with the bottle strategy).   


## Reference

* [Homebrew docs: *Taps (Third-Party Repositories)*](https://docs.brew.sh/Taps)
