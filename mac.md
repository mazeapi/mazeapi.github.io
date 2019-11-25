## Mac Important issues

### Unistall java
```sh
sudo rm -fr /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin
sudo rm -fr /Library/PreferencePanes/JavaControlPanel.prefPane
sudo rm -fr ~/Library/Application\ Support/Oracle/Java
```

### Install Valet
```sh
brew install php
composer global require laravel/valet
echo 'export PATH="/Users/user/.composer/vendor/bin:$PATH"' >> ~/.bashrc
valet start
brew install mysql@5.7
brew services start mysql@5.7
valet use php@7.2
```
> `>>` append end of the file
> `>` override everuthing
