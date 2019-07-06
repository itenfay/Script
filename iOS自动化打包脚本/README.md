[如果你觉得能帮助到你，请给一颗小星星。谢谢！(If you think it can help you, please give it a star. Thanks!](https://github.com/dgynfi/Script/tree/master/iOS自动化打包脚本)

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](iOS自动化打包脚本/LICENSE)&nbsp;

## 技术交流群(群号:155353383)

欢迎加入技术交流群，一起探讨技术问题。<br />
![](https://github.com/dgynfi/Script/raw/master/images/qq155353383.jpg)

## iOS自动化打包脚本

在一个Base工程中，通过不断复制 .xcodeproj 和 修改 xcodeproj/project.pbxproj，为project.pbxproj文件添加资源、支持的架构、Target名称、动静态库、修改最小兼容部署等，修改Info.plist的BundleID、QueriesSchemes、URLTypes、Orientations，还有修改包的ICON和初始化参数，从而输出各种需求的ipa包。

1. XCPkg Args

此脚本项目由本人独立开发完成，依赖Python和Ruby库：biplist, mod_pbxproj, rb_modproj。<br />
自编写打包控制脚本 (PkgController.sh) 在内总计有26个脚本，加上调试，历经一个多月的时间，非常地辛苦！

2. XCPkg Encryption 

将XCPkg所有脚本进行加密处理，后期把此项目集成到MacOS应用中。
