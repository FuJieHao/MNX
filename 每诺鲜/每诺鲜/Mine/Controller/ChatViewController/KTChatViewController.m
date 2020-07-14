
#import "KTChatViewContoller.h"
#import "CZMessage.h"
#import "CZMessageCell.h"
#import "CZMessageFrame.h"
@interface KTChatViewContoller ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


@property (nonatomic, strong) NSMutableArray *messageArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *textField;




@end

@implementation KTChatViewContoller


- (NSArray *)messageArray{
    if(_messageArray == nil){
        _messageArray = [CZMessage messageWihtFile:@"messages.plist"];
    }
    return _messageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //设置tableView 取消分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableview的单行表格不可被点击
    self.tableView.allowsSelection = NO;
    
    //获取通知
    
    //1.通知的发布
    // 键盘的通知由系统发布,centent post的过程由系统完成,只需要监听
    //2.通知的监听
    // >获取控制中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // >注册监听
    // > 监听任意对象发出的键盘显示的通知,当监听到之后self就会运行keyboardChange :方法
    [center addObserver:self selector:@selector(keyboardChange :) name:UIKeyboardWillShowNotification object:nil];
    //注册隐藏的通知
    [center addObserver:self selector:@selector(keyboardChange :) name:UIKeyboardWillHideNotification object:nil];
    //3.通知的移除
    // dealloc 在对象销毁的时候移除通知
    
    // 让textField输入信息的左边有一定的间隔 x y 以及高度是无效的
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 10, 1000)];
//    leftView.backgroundColor = [UIColor redColor];
    self.textField.leftView =leftView;
    //设置leftView的类型
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
}

#pragma mark UITextFiled的代理事件
/**
 *  return按钮的代理
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    NSLog(@"%s",__func__);
    
    // 1. 获取textField中的信息
    NSString *text = textField.text;
//    NSLog(@"%@",text);
    // 2. 给UITableView添加一条数据
    [self sendMessage:text :CZMessageTypeMe];
    // >>2.1 模拟其他人发送一条消息
    NSString *otherText = [NSString stringWithFormat:@"%@ 滚",text];
    [self sendMessage:otherText :CZMessageTypeOther];
    // 3. 刷新UITableView
    [self.tableView reloadData];
    
    //4. 让talbView 滚动到最后一行
    // > 4.1 定义一个NSIndexPath
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.messageArray.count-1) inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
    return NO;
}

// 发送一条消息
- (void)sendMessage:(NSString *)text :(CZMessageType) type{
    // >> 2.1 给messageArray数组添加数据
    // >> 2.1.1 将NSArray类型的数组改为NSMutableArray的数组
    //     NSMutableArray *messageArray;
    // >> 2.1.2 给messageArray数组添加数据
    // >> 2.1.2.1 添加一个模型数据
    CZMessage *message = [[CZMessage alloc]init];
    message.text = text;
    // >>>. 获取当前时间的方法
    NSDate *date = [NSDate date];
    //    NSLog(@"%@",date);
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = @"HH:mm";
    
    NSString *textFormat = [formate stringFromDate:date];
    //    NSLog(@"%@",textFormat);
    message.time = textFormat;
    
    // >>>> 获取数组中最后一个数据的时间,如果相同,则隐藏,不相同则显示时间
    CZMessage *lastMessage = [self.messageArray lastObject];
    if ([message.time isEqualToString:lastMessage.time]) {
        message.hiddenTime = YES;
    }else{
        message.hiddenTime = NO;
    }
    // >>> 设置消息是谁发送的
    message.type = type;
    
    // >>> 设置frame信息
    CZMessageFrame *messageFrame = [[CZMessageFrame alloc]init];
    messageFrame.message = message;
    
    message.messageFrame = messageFrame;
    
    // >>> 将message模型添加到数组中
    [self.messageArray addObject:message];
}

- (void)dealloc{
    //通知移除
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

//当监听到键盘显示的时候,就运行此方法
- (void)keyboardChange :(NSNotification *)note{
    
//    NSLog(@"%@",note);
//    NSConcreteNotification 0x7ff03bc8fdb0 {name = UIKeyboardWillShowNotification; userInfo = {
//        UIKeyboardAnimationCurveUserInfoKey = 7;  //动画执行的效果
//        UIKeyboardAnimationDurationUserInfoKey = "0.25"; //动画执行的时间
//        UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}"; //键盘的bounds属性
//        UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";  //键盘开始显示的中心点位置
//        UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";    //键盘结束显示的中心点位置
//        UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}"; //键盘未显示的位置
//        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";  // 键盘显示后的位置
//    }}
    //获取一下userInfo的信息
    NSDictionary *dict = note.userInfo;
    
    //键盘的Frame
    CGRect keyBoradFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //当键盘显示,让界面跟着移动
    // 1.frame //但是不建议
    // 2.center //
    // 3.transform
    // > 用transform进行位移,对整个view进行移动
    //transformY = 键盘的Y - 屏幕的高度
    CGFloat transFormY = keyBoradFrame.origin.y - self.view.frame.size.height;
    double animationDuration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transFormY-40);
    }];
    
}


//获取tableView的滚动事件,当tableView滚动时候隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"开始滚动了");
    [self.view endEditing:YES];
}

/**
 *  隐藏状态栏
 */
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark UITableView的数据源协议方法
//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArray.count;
}
//返回表格数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.根据标识获取cell
    NSString *ID = @"message";
    CZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    //2.判断如果cell为空,我们就创建新的cell
    if (cell == nil) {
        cell = [[CZMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //3.给cell设置数据
    //获取数据
    CZMessage *message = self.messageArray[indexPath.row];
    
    cell.message = message;
    
    
    //4.返回cell
    return cell;
    
    
}
//设置cell的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZMessage *message = self.messageArray[indexPath.row];
    return message.messageFrame.cellHeight;
}

@end
