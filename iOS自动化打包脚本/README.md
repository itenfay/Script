[如果你觉得能帮助到你，请给一颗小星星。谢谢！(If you think it can help you, please give it a star. Thanks!)](https://github.com/dgynfi/Script/tree/master/iOS自动化打包脚本)

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;

## 技术交流群(群号:155353383)

- 欢迎加入技术交流群，一起探讨技术问题。

<div align=left>
&emsp; <img src="https://github.com/dgynfi/Script/raw/master/images/qq155353383.jpg" width="20%" />
</div>

## iOS自动化打包脚本

&emsp; 在一个 Base 工程中，通过不断复制 .xcodeproj 和 修改 xcodeproj/project.pbxproj ，为 project.pbxproj 文件添加资源、支持的架构、Target 名称、动静态库、修改最小兼容部署等，修改 Info.plist 的 Bundle identifier , QueriesSchemes , URLTypes , Orientations ，还有修改包的 ICON 和初始化参数，从而输出各种需求的 ipa 包。

1. XCPkg Args 

&emsp; 此脚本项目由本人独立开发完成，依赖 Python 和 Ruby 库：biplist , mod_pbxproj , rb_modproj 。<br />
&emsp; 自编写了打包控制脚本 (PkgController.sh) 在内总计有26个脚本，加上调试，历时一个多月，其过程非常地辛苦！

2. XCPkg Encryption

&emsp; 将 XCPkg 所有脚本进行加密处理，并集成到[ Mac 应用 - IPAPkgTool ](https://github.com/dgynfi/IPAPkgTool)。

