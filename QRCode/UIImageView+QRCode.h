//
//  UIImageView+QRCode.h
//  QRCode
//
//  Created by WCF on 2018/3/16.
//  Copyright © 2018年 BCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (QRCode)
//普通二维码
/**
 * 生成二维码
 * QRStering: 字符串
 * imageFloat: 二维码图片大小
 */
- (UIImage *)createQRCodeWithString:(NSString *)QRString withImgsize:(CGFloat)imageFloat;
//中间有小图片的二维码
/**
 * 生成二维码(中间有小图片)
 * QRString: 字符串
 * centerImage: 二维码中间的image对象
 */
- (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage;
@end
