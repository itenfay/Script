## iOS Automated Packaging Scripts

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;

在一个 Base 工程中，通过不断复制 .xcodeproj 和 修改 xcodeproj/project.pbxproj，为 project.pbxproj 文件添加资源、支持的架构、Target 名称、动静态库、修改最小兼容部署等，修改 Info.plist 的 Bundle identifier, QueriesSchemes, URLTypes, Orientations，还有修改包的 ICON 和初始化参数，从而输出各种需求的 ipa 包。


## Group (ID:614799921)

<div align=left>
&emsp; <img src="https://github.com/chenxing640/Script/raw/master/images/g614799921.jpg" width="30%" />
</div>


## Catalog

1. XCPkg Args 

此脚本项目由本人独立开发完成，依赖 Python 和 Ruby 库：biplist, mod_pbxproj, rb_modproj。

自编写控制脚本 (PkgController.sh) 在内总计有26个脚本，再加上调试，历时一个多月，其过程非常地辛苦！！！

2. XCPkg Encryption

将 XCPkg 所有脚本进行加密处理，并集成到[ Mac 应用 - IPAPkgTool ](https://github.com/chenxing640/IPAPkgTool)。
