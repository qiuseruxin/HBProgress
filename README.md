# HBProgressHUD
一款屏幕刷新框  借鉴了FanProgress3D
使用方法:
显示刷新框\n
[HBProgress showInView:self.view status:@"正在加载"];
消失:
[HBProgress dismiss];
带文字消失:
[HBProgress dismissWithStatus:@"连接失败,请检查您的网络" afterDelay:3.0];

在刷新时,覆盖了一个backview上去禁止用户点击view(但是可以点导航条上的返回按钮返回),如果希望用户可以点击屏幕只需去.m中删掉_backview即可.
