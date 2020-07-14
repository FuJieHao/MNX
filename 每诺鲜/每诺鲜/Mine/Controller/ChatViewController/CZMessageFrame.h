//
//  CZMessageFrame.h
//  01-QQ聊天
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CZMessage;
@interface CZMessageFrame : NSObject


/**
 *  时间Label的frame
 */
@property (assign, nonatomic) CGRect timeLabelFrame;
/**
 *  用户头像的frame
 */
@property (assign, nonatomic) CGRect userImageFrame;
/**
 *  信息按钮的frame
 */
@property (assign, nonatomic) CGRect textButtonFrame;

/**
 *  行高
 */
@property (assign, nonatomic) CGFloat cellHeight;

@property (nonatomic, weak) CZMessage *message;

@end
