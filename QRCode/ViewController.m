//
//  ViewController.m
//  QRCode
//
//  Created by WCF on 2018/3/16.
//  Copyright © 2018年 BCQ. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+QRCode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**********************************************************/
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 240)/2, 30, 240, 240)];
    [self.view addSubview:imageView];
    
    //1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //2.恢复默认
    [filter setDefaults];
    //3.添加二维码扫描出来的字符串
    NSString *dataString = @"这是二维码扫出来的String";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    //4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    //5.此时的CIImage格式的二维码会有些模糊，所以将CIImage转换成UIImage,并放大显示
    imageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
    /**********************************************************/
    
    /**********************************************************/
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 240)/2, 280, 240, 240)];
//    imageView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView2];
    imageView2.image = [imageView2 createQRCodeWithString:@"普通二维码" withImgsize:300];
    /**********************************************************/
    
    /**********************************************************/
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 240)/2, 530, 240, 240)];
    [self.view addSubview:imageView3];
    imageView3.image = [imageView3 createImgQRCodeWithString:@"带图片二维码" centerImage:[UIImage imageNamed:@"centerImage.bundle/centerImage"]];
    /**********************************************************/
    
}

//将CIImage转换成UIImage的方法
/**
 * 根据CIImage生成指定大小的UIImage
 * image CIImage
 * size 图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
