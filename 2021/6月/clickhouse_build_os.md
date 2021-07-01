https://clickhouse.tech/docs/en/development/build-osx/



# How to Build ClickHouse on Mac OS X[¶](https://clickhouse.tech/docs/en/development/build-osx/#how-to-build-clickhouse-on-mac-os-x)

Build should work on x86_64 (Intel) and arm64 (Apple Silicon) based macOS 10.15 (Catalina) and higher with recent Xcode's native AppleClang, or Homebrew's vanilla Clang or GCC compilers.

## Install Homebrew[ ](https://clickhouse.tech/docs/en/development/build-osx/#install-homebrew)

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# ...and follow the printed instructions on any additional steps required to complete the installation.
```

## Install Xcode and Command Line Tools[ ](https://clickhouse.tech/docs/en/development/build-osx/#install-xcode-and-command-line-tools)

Install the latest [Xcode](https://apps.apple.com/am/app/xcode/id497799835?mt=12) from App Store.

Open it at least once to accept the end-user license agreement and automatically install the required components.

Then, make sure that the latest Command Line Tools are installed and selected in the system:

```
sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install
```

Reboot.

## Install Required Compilers, Tools, and Libraries[ ](https://clickhouse.tech/docs/en/development/build-osx/#install-required-compilers-tools-and-libraries)

```
brew update
brew install cmake ninja libtool gettext llvm gcc binutils
```

## Checkout ClickHouse Sources[ ](https://clickhouse.tech/docs/en/development/build-osx/#checkout-clickhouse-sources)

```
git clone --recursive git@github.com:ClickHouse/ClickHouse.git
# ...alternatively, you can use https://github.com/ClickHouse/ClickHouse.git as the repo URL.
```