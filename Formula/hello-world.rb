require 'debug'

# A simple Homebrew "formula" that installs a "hello world"-style shell script.
#
# Tip: debug a formula script by running Homebrew with the Ruby debugger: "rdbg". To accomplish this, I modified the
# shell script that starts the "brew.rb" Ruby script. Specifically, I modified the "exec" command near the very bottom
# of '/opt/homebrew/Library/Homebrew/brew.sh' to conditionally use "rdbg" instead of the normal Ruby interpreter.
#
#     if [[ "${HOMEBREW_RDBG}" == "true" ]]; then
#       RUBYOPT="-W1 --disable=gems" exec "${HOMEBREW_LIBRARY}/Homebrew/vendor/portable-ruby/current/bin/rdbg" "${HOMEBREW_LIBRARY}/Homebrew/brew.rb" "$@"
#     else
#       exec "${HOMEBREW_RUBY_PATH}" "${HOMEBREW_RUBY_WARNINGS}" "${HOMEBREW_RUBY_DISABLE_OPTIONS}" "${HOMEBREW_LIBRARY}/Homebrew/brew.rb" "$@"
#     fi
#
# Then, install this formula in a way that enables the Ruby debugger:
#
#     HOMEBREW_RDBG=true brew install dgroomes/homebrew-playground/hello-world
#
# Now you're in the Ruby debugger. Continue, step through, evaluate an expression, etc.
#
class HelloWorld < Formula
  desc "Say 'hello world'"

  # Specifying a homepage is useful for users to find basic information about the package.
  homepage "https://github.com/dgroomes/homebrew-playground"

  # The `url` is mandatory and is used to download the package. It sometimes represents all the resources needed to
  # represent the software but it's sometimes just a piece of the overall picture. Additional resources can be
  # specified using the `resource` method. And you can just do arbitrary things in the `install` method.
  #
  # In this case, the only resource is a Zsh script. For the sake of this tutorial, the URL is a file path on the
  # local filesystem. In a real-world scenario, you'd likely use a URL to a tarball hosted in a GitHub release or some
  # public object storage.
  url "file://#{File.expand_path("../hello-world.zsh", __dir__)}"

  version "1.0.0"

  # This is the SHA-256 checksum of the `hello-world.zsh` script. I generated it in Nushell with
  # `open hello-world.zsh | hash sha256`.
  sha256 "7c473d50fd2a9104daa66c34ed4267185698d2391c4a7c1f695f835f681f606f"

  # The `install` method defines the remaining logic to get the software fully installed on the computer. In this case,
  # we're installing a single script called `hello-world.zsh` and renaming it to `hello` in the `bin` directory.
  def install
    binding.break
    bin.install "hello-world.zsh" => "hello-world"
  end

  test do
    output = shell_output("#{bin}/hello-world")
    assert_equal "Hello, World!\n", output
  end
end
