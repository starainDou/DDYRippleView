#import <UIKit/UIKit.h>

@interface DDYRippleView : UIView
/** 圆圈宽度 默认1.5 最小0.5 最大整个视图宽度1.f/10.f */
@property (nonatomic, assign) CGFloat ringWidth;
/** 最多同时出现圆圈数量 默认3 最小1 最大5 */
@property (nonatomic, assign) NSUInteger ringCount;
/** 圆圈颜色 默认blueColor */
@property (nonatomic, assign) UIColor *ringColor;
/** 两个圆圈间填充色 默认blueColor */
@property (nonatomic, assign) UIColor *fillColor;

+ (instancetype)rippleViewWithWidth:(CGFloat)width;

- (void)startRippleAnimation;
@end
