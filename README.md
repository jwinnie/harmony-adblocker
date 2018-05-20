![](icons/full/abp-128.png)
# Harmony Adblocker
Based on Adblock Plus, with a few changes:
- Acceptable Ads is disabled by default
- Better UI

Setting Up
---------
Harmony requires Nodejs, NPM and Pipenv:
```shell
$ sudo dnf install nodejs # Fedora
$ sudo apt install nodejs npm # Ubuntu
$ sudo -H pip install pipenv
```
Set up Pipenv:
```
$ pipenv shell
$ pipenv install
```

Building the Extension
---------

> For a shortcut, use the following commands:
> ```shell
> $ make firefox
> $ make chrome
> $ make clean # Remove built extensions
> ```

Run one of the following commands in the project directory, depending on your
target platform:

    ./build.py build -t chrome -k adblockpluschrome.pem
    ./build.py build -t edge
    ./build.py build -t gecko

This will create a build with a name in the form
_adblockpluschrome-1.2.3.nnnn.crx_, _adblockplusedge-1.2.3.nnnn.appx_ or
_adblockplusfirefox-1.2.3.nnnn.xpi_.

Note that you don't need an existing signing key for Chrome, a new key
will be created automatically if the file doesn't exist.

The Microsoft Edge build _adblockplusedge-1.2.3.nnnn.appx_ is unsigned and
is only useful for uploading into Windows Store, where it will be signed. For
testing use the devenv build.

The Firefox extension will be unsigned, and therefore is mostly only useful for
upload to Mozilla Add-ons. You can also also load it for testing purposes under
_about:debugging_ or by disabling signature enforcement in Firefox Nightly.

### Development environment

To simplify the process of testing your changes you can create an unpacked
development environment. For that run one of the following commands:

    ./build.py devenv -t chrome
    ./build.py devenv -t edge
    ./build.py devenv -t gecko

This will create a _devenv.*_ directory in the repository. You can load the
directory as an unpacked extension, under _chrome://extensions_ in Chrome,
under _about:debugging_ in Firefox or in _Extensions_ menu in Microsoft Edge,
after enabling extension development features in _about:flags_.
After making changes to the source code re-run the command to update the
development environment. In Chrome and Firefox the extension should reload
automatically after a few seconds.

Builds for Microsoft Edge do not automatically detect changes, so after
rebuilding the extension you should manually force reloading it in Edge by
hitting the _Reload Extension_ button.

The build script calls the ensure_dependencies script automatically to manage
the dependencies (see _dependencies_ file). Dependencies with local
modifications won't be updated. Otherwise during development specifying a
feature-branch's name for a dependency's revision is sometimes useful.
Alternatively dependency management can be disabled completely by setting the
_SKIP_DEPENDENCY_UPDATES_ environment variable, for example:

    SKIP_DEPENDENCY_UPDATES=true ./build.py devenv -t chrome

Running the unit tests
----------------------

To verify your changes you can use the unit test suite located in the _qunit_
directory of the repository. In order to run the unit tests go to the
extension's Options page, open the JavaScript Console and type in:

    location.href = "qunit/index.html";

The unit tests will run automatically once the page loads.

Linting
-------

You can lint the code using [ESLint](http://eslint.org).

    eslint *.js lib/ qunit/ ext/ chrome/

You will need to set up ESLint and our configuration first, see
[eslint-config-eyeo](https://hg.adblockplus.org/codingtools/file/tip/eslint-config-eyeo)
for more information.

Testing/Installing
-------

*Firefox*: go to `about:debugging` and click `Load Temporary Add-On`
*Chrome*: go to `chrome://extensions`, enable `Developer Mode` and click `Load unpacked extension...`
