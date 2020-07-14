//
//  CZMessageFrame.m
//  01-QQ聊天
//
//

#import "CZMessageFrame.h"
#import "CZMessage.h"

#define timeLableH 20
#define padding 15
#define userImageWH 50
#define textSizeW 200
#define textFont [UIFont systemFontOfSize:17]
#define textButtonPadding 20

@implementation CZMessageFrame


/**
 *  重写message数据的setter方法,在设置数据的时候,设置frame
 */
- (void)setMessage:(CZMessage *)message{
    //1.完成赋值
    _message = message;
    //2.根据message信息计算控件的frame
    
    // >>计算屏幕的宽度
    CGFloat  viewW = [UIScreen mainScreen].bounds.size.width;

    // 2.1>timeLabel的frame
    self.timeLabelFrame = CGRectMake(0, 0, viewW, timeLableH);
    
    
    // 2.2>头像的frame
    
    CGFloat userImageX ;
    CGFloat userImageY = CGRectGetMaxY(self.timeLabelFrame) ;
    CGFloat userImageW = userImageWH;
    CGFloat userImageH = userImageWH;
    
    if (message.type == CZMessageTypeMe) {
        //自己头像,显示在右边
        //X = 屏幕的宽度 - 间距padding - 头像的宽度
        userImageX = viewW - padding - userImageW;
    }else{
//        CZMessageTypeOther 它人头像显示在左边
        //左边的x = 间距
        userImageX = padding;
    }
    self.userImageFrame = CGRectMake(userImageX, userImageY, userImageW, userImageH);
    // 2.3>计算信息按钮的frame
    
    CGFloat textButtonX ;
    CGFloat textButtonY = userImageY ;
    
    
#warning 重点要理解,根据文本信息计算宽高
    NSString  *text = message.text;
    //CGSize: 定义文本的区间,显示文本显示的区域
    //options:显示的方式 NSStringDrawingUsesLineFragmentOrigin
    //attributes : UIKit -》NSAtributeString --> 结构体的key
    //key  NSFontAttributeName  value : font对象
    
    CGRect textRect =[text boundingRectWithSize:CGSizeMake(textSizeW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : textFont} context:nil];
    
    CGFloat textButtonW = textRect.size.width + textButtonPadding * 2 ;
    CGFloat textButtonH = textRect.size.height + textButtonPadding ;
    
    if (message.type) {
        //代表其他人 >0 代表true CZMessageTypeOther
        //x = 具体左边的pading + 图片的宽度 + padding
        textButtonX = userImageH + padding *2;
    }else{
        //代表自己 = 0 代表false Me
        //x = 屏幕的宽度 - 头像距离右边的间距 - 头像的宽度 - 间距- 控件的宽度
        textButtonX = viewW - (userImageH + padding*2) -textButtonW;
        
    }
    self.textButtonFrame = CGRectMake(textButtonX, textButtonY, textButtonW, textButtonH);
    
    //行高
    //文本按钮的最下方的y + padding
    // >1 获取文本按钮的最大的Y
    CGFloat textMaxY =  CGRectGetMaxY(self.textButtonFrame) + padding;
    // >2 获取头像的最大的Y
    CGFloat userImageMaxY = CGRectGetMaxY(self.userImageFrame) + padding;
    self.cellHeight = textMaxY > userImageMaxY ? textMaxY :userImageMaxY;
    
}

@end








