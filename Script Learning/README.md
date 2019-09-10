[如果你觉得能帮助到你，请给一颗小星星。谢谢！(If you think it can help you, please give it a star. Thanks!)](https://github.com/dgynfi/Script)

## 技术交流群(群号:155353383)

- 欢迎加入技术交流群，一起探讨技术问题。

<div align=left>
<img src="https://github.com/dgynfi/Script/raw/master/images/qq155353383.jpg" width="20%" />
</div>

## MacOS App调用执行脚本

- 调用执行脚本响应事件

```
- (IBAction)invokeCommand:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AddFrameworkSearchPath" ofType:@"py"];
    //NSLog(@"path: %@", path);
    
    NSString *pbxprojPath = @"/Users/xxx/Desktop/TT/TT.xcodeproj";
    pbxprojPath = [pbxprojPath stringByAppendingPathComponent:@"project.pbxproj"];
    //NSLog(@"pbxprojectPath: %@", pbxprojPath);
    
    NSString *frameworkSearchPath = @"/Users/xxx/mywks/SDK/XCPaySDK.framework";
    NSString *target = @"TT";
    NSDictionary *argsDict = @{@"pxbprojPath": pbxprojPath, @"frameworkSearchPath": frameworkSearchPath, @"target": target};
   
    [self executeCMD:path dict:argsDict];
}
```

- 创建并配置任务

``` objc
- (void)executeCMD:(NSString *)path dict:(NSDictionary *)dict {
    NSString *pxbprojPath = [dict objectForKey:@"pxbprojPath"];
    NSString *frameworkSearchPath = [dict objectForKey:@"frameworkSearchPath"];
    NSString *target = [dict objectForKey:@"target"];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/python"];
    [task setArguments:@[path, pxbprojPath, frameworkSearchPath, target]];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(watchRun:) userInfo:task repeats:YES];
    
    [task launch];
}
```

- 监视任务

```
- (void)watchTask:(NSTimer *)timer {
    NSTask *task = (NSTask *)timer.userInfo;
    if (![task isRunning]) {
        [timer invalidate];
        timer = nil;
        task = nil;
        
        NSAlert *alert = [NSAlert alertWithMessageText:@"提示" defaultButton:@"确定" alternateButton:nil otherButton:nil informativeTextWithFormat:@"执行成功"];
        [alert setAlertStyle:NSInformationalAlertStyle];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        
        }];
    }
}
```
