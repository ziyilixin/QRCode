# QRCode
二维码生成工具
## 普通二维码
```objc
- (UIImage *)createQRCodeWithString:(NSString *)QRString withImgsize:(CGFloat)imageFloat;
```
## 中间有小图片的二维码
```objc
- (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage;
```
