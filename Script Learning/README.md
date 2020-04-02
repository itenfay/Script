
## Group (ID:155353383)

<div align=left>
&emsp; <img src="https://github.com/dgynfi/Script/raw/master/images/qq155353383.jpg" width="30%" />
</div>


## MacOS-App Invoke executable Script

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

```
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
