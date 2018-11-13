# QRCode
二维码生成工具

屏幕截图
![image](https://github.com/ziyilixin/QRCode/blob/master/QRCode/Picture/QRCode.png?raw=true)

## 普通二维码
```objc
- (UIImage *)createQRCodeWithString:(NSString *)QRString withImgsize:(CGFloat)imageFloat;
```
## 中间有小图片的二维码
```objc
- (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage;
```
