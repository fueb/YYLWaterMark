//
//  YYLWaterMark.h
//  waterMarkDemo
//
//  Created by yyl on 2020/9/25.
//  Copyright © 2020 yyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

/// <#Description#>
@interface YYLWaterMark : NSObject

/// 图片添加水印
/// @param img 目标图片
/// @param name 水印内容
/// @param fontsize 水印字体大小
/// @param angle 偏转角度
+ (UIImage *)watermarkImage:(UIImage *)img withName:(NSString *)name withFontSize:(float)fontsize withAngle:(CGFloat) angle;
@end

NS_ASSUME_NONNULL_END
