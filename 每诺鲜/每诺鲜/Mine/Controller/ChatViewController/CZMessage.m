//
//  CZMessage.m
//  01-QQ聊天
//
//

#import "CZMessage.h"
#import "CZMessageFrame.h"
@implementation CZMessage


- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        self.messageFrame = [[CZMessageFrame alloc]init];
        //为了计算frame 需要将数据赋值给messageFrame对象
        self.messageFrame.message = self;
    }
    return self;
}

+ (instancetype)messageWithDict:(NSDictionary *)dict{
    return  [[self alloc]initWithDict:dict];
}

+ (NSArray *)messageWihtFile:(NSString *)fileName{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:nil]];
    NSMutableArray *nma = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        //加载数据的时候判断是否显示时间,如果时间相同就不显示
        
//        [nma addObject:[self messageWithDict:dict]];
        //根据字典数据获取模型数据
        CZMessage *message = [self messageWithDict:dict];
        //想设置这个值,需要判断跟它上一个数据中的time是否相同
        // >1 获取自己的time
        NSString *time = message.time;
        // >2 获取上一个数据的time
        // >2.1 获取上一个数据
        CZMessage *lastMessage = [nma lastObject];
        // >2.2 获取到上一个数据的time
        NSString *lastTime = lastMessage.time;
        
        message.hiddenTime = [time isEqualToString:lastTime];
        
        [nma addObject:message];
        
        
        
    }
    
    return  nma;
}

@end
