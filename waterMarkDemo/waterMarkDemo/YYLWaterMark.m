//
//  YYLWaterMark.m
//  waterMarkDemo
//
//  Created by yyl on 2020/9/25.
//  Copyright © 2020 yyl. All rights reserved.
//

#import "YYLWaterMark.h"

@implementation YYLWaterMark

+ (UIImage *)watermarkImage:(UIImage *)img withName:(NSString *)name withFontSize:(float)fontsize withAngle:(CGFloat) angle
{
    
    int w = img.size.width;
    
    int h = img.size.height;
    
    int hypotenuse = 0;//画布对角边长
    
    float font = fontsize;
    
    hypotenuse = sqrt(w*w + h*h);
    
    name = [name stringByAppendingString:@"  "];
    
    int i = 0;
    
    while (i < 10)
    {
        i++;

        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
        CGSize detailSize = [name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        if (detailSize.width > hypotenuse)
        {
            break;
        }
        
        name = [name stringByAppendingString:name];
    }
    
    
    UIGraphicsBeginImageContext(img.size);
    
    [img drawInRect:CGRectMake(0, 0, w, h)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    MyDrawText(context, CGRectMake(0, 0, w, h),name,font,angle);

    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return aimg;
    
}


void MyDrawText (CGContextRef myContext, CGRect contextRect ,NSString *waterStr,float font, CGFloat angle) //

{
    
    float w, h;
    
    w = contextRect.size.width;
    
    h = contextRect.size.height;
    
    CGAffineTransform myTextTransform; //
    
    
    CGContextSetCharacterSpacing (myContext, 0); //
    
    CGContextSetTextDrawingMode (myContext, kCGTextFillStroke); //
    
    
    
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 0.55); //
    
    CGContextSetRGBStrokeColor (myContext, 0, 0, 1, 0.55); //
    
    //偏转角度
    myTextTransform =  CGAffineTransformMakeRotation (angle); //
    
    CGContextSetTextMatrix (myContext, myTextTransform); //
    //
    
    UniChar *characters;
    CGGlyph *glyphs;
    CFIndex count;
    
    CTFontRef ctFont = CTFontCreateWithName(CFSTR("STHeitiSC-Light"), font, NULL);//
    CTFontDescriptorRef ctFontDesRef = CTFontCopyFontDescriptor(ctFont);
    CFNumberRef pointSizeRef = (CFNumberRef)CTFontDescriptorCopyAttribute(ctFontDesRef,kCTFontSizeAttribute);
    CGFontRef cgFont = CTFontCopyGraphicsFont(ctFont,&ctFontDesRef );
    CGContextSetFont(myContext, cgFont);
    
    CGFloat fontSize = font;
    NSString* str2 = waterStr;
    CFNumberGetValue(pointSizeRef, kCFNumberCGFloatType,&fontSize);
    CGContextSetFontSize(myContext, font);//z字体大小并不是字号
    CGContextSetAlpha(myContext, 0.55);
    count = CFStringGetLength((CFStringRef)str2);
    characters = (UniChar *)malloc(sizeof(UniChar) * count);
    glyphs = (CGGlyph *)malloc(sizeof(CGGlyph) * count);
    CFStringGetCharacters((CFStringRef)str2, CFRangeMake(0, count), characters);
    
    CTFontGetGlyphsForCharacters(ctFont, characters, glyphs, count);
    CGContextScaleCTM(myContext, 1, -1);
    CGContextMoveToPoint(myContext, w/2, h/2);

    //具体绘制的水印数量
    CGContextShowGlyphsAtPoint(myContext, 0, -h/2, glyphs, str2.length);
    CGContextShowGlyphsAtPoint(myContext, 0, -h, glyphs, str2.length);
    CGContextShowGlyphsAtPoint(myContext, w /2, -h, glyphs, str2.length);
    free(characters);
    free(glyphs);//
    
}
@end
