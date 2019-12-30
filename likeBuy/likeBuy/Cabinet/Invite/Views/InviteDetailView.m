//
//  InviteDetailView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/9/4.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "InviteDetailView.h"

@interface InviteDetailView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *yaoqingmaLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yaoqingmaLabelW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yaoqingmaLabelTop;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;

@end

@implementation InviteDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"InviteDetailView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    if (IPHONE6HEIGHT > ScreenHeight) {
        self.yaoqingmaLabelTop.constant = CGRectGetHeight(self.bounds) *0.6;
    }else{
        self.yaoqingmaLabelTop.constant = CGRectGetHeight(self.bounds) *0.61;
    }
    
    
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

-(void)setYaoqingmaStr:(NSString *)yaoqingmaStr{
    _yaoqingmaStr = yaoqingmaStr;
    
    if (yaoqingmaStr != nil) {
        
        [self.yaoqingmaLabel setHidden:NO];
        [self.yaoqingmaLabel setText:[NSString stringWithFormat:@"邀请码：%@",yaoqingmaStr]];
        
        CGFloat width =  [self getWidthWithText:self.yaoqingmaLabel.text height:35 font:17] +25;
        
        self.yaoqingmaLabelW.constant = width;
        
        self.yaoqingmaLabel.layer.cornerRadius = 8;
        self.yaoqingmaLabel.layer.masksToBounds = YES;
    }else{
        [self.yaoqingmaLabel setHidden:YES];
    }
}

-(void)setCodeStr:(NSString *)codeStr{
    _codeStr = codeStr;
    
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    
    NSString *string =  @"http://shop.alhuigou.com";
    
    if (codeStr != nil && codeStr.length > 0) {
        string = codeStr;
    }
    
    //将NSString格式转化成NSData格式
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    //获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];
    
    //将获取到的二维码添加到imageview上
//    [UIImage imageWithCIImage:image]
    self.codeImageView.image = [self resizeQRCodeImage:image withSize:125];
}


- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat )font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}

-(UIImage *)resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, extent, imageRef);
    
    CGImageRef imageRefResized = CGBitmapContextCreateImage(contextRef);
    
    //Release
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    return [UIImage imageWithCGImage:imageRefResized];
}

@end
