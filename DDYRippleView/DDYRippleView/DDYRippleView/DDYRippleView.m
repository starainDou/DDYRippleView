#import "DDYRippleView.h"

@interface DDYRippleView ()

@property (nonatomic, strong) NSTimer *rippleTimer;

@end


@implementation DDYRippleView

+ (instancetype)rippleViewWithWidth:(CGFloat)width {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, width, width)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.ringWidth = 1.5;
        self.ringCount = 3;
        self.ringColor = [UIColor blueColor];
        self.fillColor = [UIColor blueColor];
    }
    return self;
}

- (void)startRippleAnimation {
    if (self.ringWidth*self.ringCount*2 > self.bounds.size.width) {
        NSLog(@"设置的视图宽度太小或者圆圈宽度太大或者允许同时出现的圆圈太多，，，容不下了你知道不？");
        return;
    } else if (self.ringCount<1 || self.ringCount>5) {
        NSLog(@"设置允许同时出现的圆圈太多，，，设置太多体验能好吗？");
        return;
    } else if (self.ringWidth < 0.5 || self.ringWidth > self.bounds.size.width/10.f) {
        NSLog(@"有本事你设置的ringWidth再宽点，，，窄点你不觉得会更好看？");
        return;
    } else {
        [self closeRippleTimer];
        _rippleTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.rippleTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)startAnimation {
    CGRect startRect = CGRectOffset(CGRectMake(self.bounds.size.width/2., self.bounds.size.height/2., 30, 30), -15, -15);
    CGRect endRect = CGRectInset(startRect, -(self.bounds.size.width/2.-15), -(self.bounds.size.height/2.-15));
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:startRect];
    UIBezierPath *endPath   = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0];;
    
    CABasicAnimation *rippleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    rippleAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    rippleAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = self.ringCount;
    animationGroup.animations = @[opacityAnimation, rippleAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAShapeLayer *rippleLayer = [CAShapeLayer layer];
    [rippleLayer setBounds:self.bounds];
    [rippleLayer setPosition:CGPointMake(self.bounds.size.width/2., self.bounds.size.height/2.)];
    [rippleLayer setBackgroundColor:[UIColor clearColor].CGColor];
    [rippleLayer setStrokeColor:self.ringColor.CGColor];
    [rippleLayer setFillColor:self.fillColor.CGColor];
    [rippleLayer setLineWidth:self.ringWidth];
    [rippleLayer setPath:startPath.CGPath];
    [rippleLayer addAnimation:animationGroup forKey:@""];
    [self.layer addSublayer:rippleLayer];
    [self performSelector:@selector(removeRippleLayer:) withObject:rippleLayer afterDelay:self.ringCount];
}

- (void)removeRippleLayer:(CAShapeLayer *)rippleLayer {
    [rippleLayer removeFromSuperlayer];
    rippleLayer = nil;
}

- (void)closeRippleTimer {
    if (_rippleTimer) {
        if ([_rippleTimer isValid]) {
            [_rippleTimer invalidate];
        }
        _rippleTimer = nil;
    }
}

@end
/**
 问题: 当一个循环后，由于最后一个layer在最上层并且透明度不为0，此时会出现第一个已经二次循环的layer被遮挡，颜色出现差异
 方案一:分割圆环，比如三个圆环时根据半径分割成三个圆环，第一个只从0扩大到1/3宽度，第二个从1/3宽度扩大到2/3，类推。这样互不遮挡
 方案二:中间镂空圆环，防止遮挡。
 */

/**
 CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
 animationGroup.removedOnCompletion = NO;
 animationGroup.duration = self.ringCount;
 animationGroup.repeatCount = MAXFLOAT;
 animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
 animationGroup.fillMode = kCAFillModeForwards;
 animationGroup.animations = @[opacityAnimation, rippleAnimation];
 [rippleLayer addAnimation:animationGroup forKey:@" "];
 */
