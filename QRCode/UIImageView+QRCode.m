//
//  UIImageView+QRCode.m
//  QRCode
//
//  Created by WCF on 2018/3/16.
//  Copyright © 2018年 BCQ. All rights reserved.
//

#import "UIImageView+QRCode.h"

@implementation UIImageView (QRCode)
//普通二维码
/**
 * 生成二维码
 * QRStering: 字符串
 * imageFloat: 二维码图片大小
 */
- (UIImage *)createQRCodeWithString:(NSString *)QRString withImgsize:(CGFloat)imageFloat
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSString *getString = QRString;
    NSData *dataString = [getString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:dataString forKey:@"inputMessage"];
    //获取滤镜输出的图像
    CIImage *outImage = [filter outputImage];
    UIImage *imageV = [self imageWithImageSize:imageFloat withciImage:outImage];
    //返回二维码图像
    return imageV;
}

//将CIImage转换成UIImage并放大(内部转换使用)
- (UIImage *)imageWithImageSize:(CGFloat)size withciImage:(CIImage *)ciImage
{
    CGRect extent = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    //2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

//中间有小图片的二维码
/**
 * 生成二维码(中间有小图片)
 * QRString: 字符串
 * centerImage: 二维码中间的image对象
 */
- (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage
{
    //创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    //将字符串转换成NSData
    NSData *dataString = [QRString dataUsingEncoding:NSUTF8StringEncoding];
    //设置过滤器的输入值，KVC赋值
    [filter setValue:dataString forKeyPath:@"inputMessage"];
    //获得滤镜输出的图像
    CIImage *outImage = [filter outputImage];
    //图片小于(27,27)我们需要放大
    outImage = [outImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    //将CIImage类转换成UIImage类型
    UIImage *startImage = [UIImage imageWithCIImage:outImage];
    //开启绘图，获取图像上下文
    UIGraphicsBeginImageContext(startImage.size);
    [startImage drawInRect:CGRectMake(0, 0, startImage.size.width, startImage.size.height)];
    //再把小图片画上去
    CGFloat icon_imageW = 100;
    CGFloat icon_imageH = icon_imageW;
    CGFloat icon_imageX = (startImage.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY = (startImage.size.height - icon_imageH) * 0.5;
    [centerImage drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    //获取当前画得这张图片
    UIImage *qrImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    //返回二维码图像
    return qrImage;
}

@end
