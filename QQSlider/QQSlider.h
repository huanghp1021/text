//
//  QQSlider.h
//  MySlider
//
//  Created by 朱伟特 on 16/5/15.
//  Copyright © 2016年 朱伟特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQSliderDelegate <NSObject>

@optional
- (void)scoreDidChange:(NSString *)score;

@end
@interface QQSlider : UIControl

@property (nonatomic, weak) id<QQSliderDelegate>delegate;

@end
