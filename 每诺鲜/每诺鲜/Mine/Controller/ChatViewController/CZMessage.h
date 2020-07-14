//
//  CZMessage.h
//  01-QQ聊天
//
//

#import <Foundation/Foundation.h>
@class CZMessageFrame;

typedef enum {
    CZMessageTypeMe =0,
    CZMessageTypeOther
} CZMessageType;

@interface CZMessage : NSObject


@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *time;
/**
 *  用来判断是否显示时间
 */
@property (assign, nonatomic,getter=isHiddenTime) BOOL hiddenTime;

// 枚举
@property (assign, nonatomic) CZMessageType type;


@property (nonatomic, strong) CZMessageFrame *messageFrame;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)messageWithDict:(NSDictionary *)dict;

+ (NSArray *)messageWihtFile:(NSString *)fileName;



@end
