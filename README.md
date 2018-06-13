# DDYRippleView


* 能够随时修改圆环(圆线)宽度
* 能够随时圆环(圆线)颜色
* 能够随时修改填充颜色的涟漪波纹
* 从中心向四周扩散动画

![DDYRippleView.png](https://github.com/starainDou/DDYRippleView/blob/master/DDYRippleView.png)

### 默认

```
self.ringWidth = 1.5;
self.ringCount = 3;
self.ringColor = [UIColor blueColor];
self.fillColor = [UIColor blueColor];
```

```
CGFloat width1 = [UIScreen mainScreen].bounds.size.width;
    DDYRippleView *rippleView1 = [DDYRippleView rippleViewWithWidth:width1];
    rippleView1.center = CGPointMake(self.view.bounds.size.width/2., DDYTopH + width1/2.);
    [rippleView1 startRippleAnimation];
    [self.view addSubview:rippleView1];
```

### 自定义

```
CGFloat width2 = 200;
    DDYRippleView *rippleView2 = [DDYRippleView rippleViewWithWidth:width2];
    rippleView2.center = CGPointMake(self.view.bounds.size.width/2., CGRectGetMaxY(rippleView1.frame)+width2/2. + 20);
    rippleView2.ringWidth = 10;
    rippleView2.ringCount = 3;
    rippleView2.ringColor = [UIColor blueColor];
    rippleView2.fillColor = [UIColor redColor];
    [rippleView2 startRippleAnimation];
    [self.view addSubview:rippleView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        rippleView2.ringColor = [UIColor redColor];
        rippleView2.fillColor = [UIColor yellowColor];
    });
```
