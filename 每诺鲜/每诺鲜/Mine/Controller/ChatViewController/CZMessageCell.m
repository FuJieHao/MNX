//
//  CZMessageCell.m
//  01-QQ聊天
//
//

#import "CZMessageCell.h"
#import "CZMessage.h"
#import "CZMessageFrame.h"

#define timeLableFont [UIFont systemFontOfSize:14]
#define textFont [UIFont systemFontOfSize:17]
#define textButtonPadding 20

@interface CZMessageCell ()

@property (weak, nonatomic) UILabel *timeLabel;
@property (weak, nonatomic) UIImageView *userImage;
@property (weak, nonatomic) UIButton *textButton;

@end

@implementation CZMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    //调用父类的方法
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //加载控件
        [self loadSubViews];
        //清楚cell自带的背景颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


#pragma mark 加载自定义的子控件
/**
 *  加载子控件
 */
- (void)loadSubViews{
    //1.时间控件,UILabel
    UILabel *timeLabel = [[UILabel alloc]init];
    //设置文字居中
    timeLabel.textAlignment = NSTextAlignmentCenter;
    //设置文字大小
    timeLabel.font = timeLableFont;
    // >设置frame
    // 设置frame需要数据,这里没有办法进行设置,所以先不设置
    // 在加载数据的时候再进行设置
    
    // >添加控件到它的父控件中
    
    self.timeLabel = timeLabel;
    [self.contentView addSubview:timeLabel];
    
    //2.用户头像 UIImageView
    UIImageView *userImage = [[UIImageView alloc]init];
    
    
    self.userImage = userImage;
    [self.contentView addSubview:userImage];
    
    //3.文本信息 UIButton
    UIButton *textButton = [[UIButton alloc]init];
    //设置button中的titleLable的font属性
    textButton.titleLabel.font = textFont;
    //设置换行
    textButton.titleLabel.numberOfLines = 0;
    [textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置内边距
    textButton.titleEdgeInsets = UIEdgeInsetsMake(textButtonPadding * 0.5, textButtonPadding, textButtonPadding *0.5, textButtonPadding);
    self.textButton = textButton;
    [self.contentView addSubview:textButton];
}


#pragma mark 加载数据
//重写设置数据的setter方法
- (void)setMessage:(CZMessage *)message{
    
    //重写setter方法第一步赋值
    _message = message;
    
    //1.加载数据
    [self loadMessageDate];
    //2.设置frame
    [self setSubViewSFrame];
}

/**
 *  加载数据
 */
- (void)loadMessageDate{
    
    //设置时间
    // >加一个判断,当时间与之前的相同,就不显示时间
    if(self.message.isHiddenTime){
        self.timeLabel.text = nil;
    }else{
        self.timeLabel.text = self.message.time;
    }
    
    //设置用户头像
    if (self.message.type == CZMessageTypeMe) {
        //加载自己头像
        self.userImage.image = [UIImage imageNamed:@"author"];
    }else{
//        CZMessageTypeOther 加载其他人头像
        self.userImage.image = [UIImage imageNamed:@"author1"];
    }
    
    //设置文本信息
    [self.textButton setTitle:self.message.text forState:UIControlStateNormal];
//    self.textButton.backgroundColor = [UIColor yellowColor];
    //设置背景图片
    if (self.message.type) {
        //其他人的图片 CZMessageTypeOther
        
        UIImage *textImage = [UIImage imageNamed:@"chat_recive_nor"];
        //64 *56
        UIImage *lastTextImage =[textImage resizableImageWithCapInsets:UIEdgeInsetsMake(textImage.size.height * 0.5, textImage.size.width * 0.5, textImage.size.height * 0.5, textImage.size.width * 0.5) ];
//        UIImage *lastTextImage = [textImage resizableImageWithCapInsets:UIEdgeInsetsMake(textImage.size.height * 0.5, textImage.size.width * 0.5, textImage.size.height * 0.5, textImage.size.width * 0.5) resizingMode:UIImageResizingModeStretch];
        
        [self.textButton setBackgroundImage:lastTextImage forState:UIControlStateNormal];
        [self.textButton setBackgroundImage:[UIImage imageNamed:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
        
    }else{
//        CZMessageTypeMe
        UIImage *textImage = [UIImage imageNamed:@"chat_send_nor"];
        // right = width - leftCapWidth - 1
        // width - left - right = 1
//        bottom = height - topCapWidth - 1
        // height - top -bottom = 1

        UIImage *lastImage = [textImage stretchableImageWithLeftCapWidth:textImage.size.width *0.5 topCapHeight:textImage.size.height *0.5];
        
        [self.textButton setBackgroundImage:lastImage  forState:UIControlStateNormal];
        [self.textButton setBackgroundImage:[UIImage imageNamed:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
    }
}

/**
 *  设置frame
 */
- (void)setSubViewSFrame{
    
//    self.timeLabel.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    //时间的frame
    self.timeLabel.frame = self.message.messageFrame.timeLabelFrame;
    //头像的frame
    self.userImage.frame = self.message.messageFrame.userImageFrame;
    //文本按钮的frame
    self.textButton.frame = self.message.messageFrame.textButtonFrame;
}

@end










