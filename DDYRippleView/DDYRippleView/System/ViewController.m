#import "ViewController.h"
#import "DDYRippleView.h"

#define DDYTopH (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width1 = [UIScreen mainScreen].bounds.size.width;
    DDYRippleView *rippleView1 = [DDYRippleView rippleViewWithWidth:width1];
    rippleView1.center = CGPointMake(self.view.bounds.size.width/2., DDYTopH + width1/2.);
    [rippleView1 startRippleAnimation];
    [self.view addSubview:rippleView1];
    
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
}

@end
