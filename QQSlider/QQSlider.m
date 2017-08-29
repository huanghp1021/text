//
//  QQSlider.m
//  MySlider
//
//  Created by 朱伟特 on 16/5/15.
//  Copyright © 2016年 朱伟特. All rights reserved.
//

#import "QQSlider.h"

#define BLUETitleColor   [UIColor colorWithRed:0x55/255.0f green:0xA3/255.0f blue:0xE6/255.0f alpha:1]//蓝色文字
#define WS(weakSelf)  __weak typeof(self)weakSelf = self;
@interface QQSlider()
{
    NSString * score;
}
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIView * fommerView;
@property (nonatomic, strong) UIButton * sliderButton;

@end
@implementation QQSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self loadUI];
    }
    return self;
}
#pragma mark - PrivateFunction
- (void)loadUI
{
    [self layOut];
}
- (void)layOut
{
    [self addSubview:self.bottomView];
    [self addSubview:self.fommerView];
    [self addSubview:self.sliderButton];
}
- (void)changePoint:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self];
    if (point.x < 0 || point.x > self.bounds.size.width) {
        return;
    }
    self.sliderButton.center = CGPointMake(point.x, self.sliderButton.center.y);
    self.fommerView.frame = CGRectMake(0, 0, point.x, self.fommerView.frame.size.height);
    score = [[NSString stringWithFormat:@"%.1f", point.x * 10 / self.bounds.size.width] substringToIndex:3];
    if ([score isEqualToString:@"0.0"]) {
        score = @"0";
    }
    if ([score isEqualToString:@"10."]) {
        score = @"10";
    }

}
- (void)delegateShouldChangeScore
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scoreDidChange:)]) {
        [self.delegate scoreDidChange:score];
    }
}
#pragma mark - UIControlFunction
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self changePoint:touch];
    return YES;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self changePoint:touch];
    [self sendActionsForControlEvents:UIControlEventValueChanged];//Target - Action机制，相当于UIButton添加方法，传入的最后参数UIControlEventValueChanged
    [self delegateShouldChangeScore];
    return YES;
}
#pragma mark - LazyLoading
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:self.bounds];
        _bottomView.backgroundColor = [UIColor lightGrayColor];
        _bottomView.userInteractionEnabled = NO;
    }
    return _bottomView;
}
- (UIView *)fommerView
{
    if (!_fommerView) {
        _fommerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.bounds.size.height)];
        _fommerView.backgroundColor = BLUETitleColor;
        _fommerView.userInteractionEnabled = NO;
    }
    return _fommerView;
}
- (UIButton *)sliderButton
{
    if (!_sliderButton) {
        _sliderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sliderButton.frame = CGRectMake(0, -4, self.bounds.size.width / 20, self.bounds.size.height + 8);
        _sliderButton.layer.borderWidth = 1.0f;
        _sliderButton.backgroundColor = BLUETitleColor;
        _sliderButton.userInteractionEnabled = NO;
        _sliderButton.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _sliderButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
