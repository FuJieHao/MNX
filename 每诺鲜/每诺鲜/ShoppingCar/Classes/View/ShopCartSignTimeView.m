//
//  ShopCartSignTimeView.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "ShopCartSignTimeView.h"


@interface ShopCartSignTimeView ()

/** 时间选择器 */
@property (nonatomic,strong) UIDatePicker *timePicker;
/** 时间 */
@property (nonatomic,copy) NSString *timeStr;
/** 收货时间 */
@property (nonatomic,weak) UITextField *signTimeField;

@end

@implementation ShopCartSignTimeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTimeClick:)];
        [self addGestureRecognizer:tap];
        
        UILabel *signTimeTitleLabel = [[UILabel alloc]init];
        signTimeTitleLabel.text = @"收货时间";
        [signTimeTitleLabel sizeToFit];
        signTimeTitleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:signTimeTitleLabel];
        
        UITextField *signTimeField = [[UITextField alloc] init];
        signTimeField.frame = CGRectMake(CGRectGetMaxX(signTimeTitleLabel.frame) + 10, 0, Width * 0.5, Height);
        signTimeField.textColor = [UIColor redColor];
        signTimeField.font = [UIFont systemFontOfSize:12];
        signTimeField.placeholder = @"(可预订)";
        [signTimeField setValue:[UIColor orangeColor] forKeyPath:@"placeholderLabel.textColor"];
        [self addSubview:signTimeField];
        _signTimeField = signTimeField;
        signTimeField.inputView = self.timePicker;
        // 创建附加键盘的确定取消按钮
        signTimeField.inputAccessoryView = [self buildInputView];
        
        UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_go"]];
        [self addSubview:arrowImageView];
        
        UILabel *descriptionLabel = [[UILabel alloc]init];
        descriptionLabel.text = @"￥0元起送,22：00前免运费,22：00后慢￥69减免运费";
        [descriptionLabel sizeToFit];
        descriptionLabel.font = [UIFont systemFontOfSize:13];
        descriptionLabel.textColor = [UIColor grayColor];
        [self addSubview:descriptionLabel];
        
        [signTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.top.equalTo(self).offset(10);
        }];
       
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-10);
            make.centerY.equalTo(signTimeTitleLabel);
        }];
        
        [signTimeField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(arrowImageView.mas_leading).offset(-20);
            make.centerY.equalTo(signTimeTitleLabel);
        }];
        
        
        [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(signTimeTitleLabel);
            make.top.equalTo(arrowImageView.mas_bottom).mas_equalTo(10);
        }];
        
    }
    return self;
}

- (UIView *)lineView:(CGRect)frame {
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    return lineView;
}


#pragma mark - 日期选择
/**
 *  辅助键盘
 *
 *  @return 辅助键盘
 */
- (UIView *)buildInputView  {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, Width, 40)];
    toolBar.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.2;
    [toolBar addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.alpha = 0.8;
    titleLabel.text = @"选择时间";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    [toolBar addSubview:titleLabel];
    
    UIButton *cancleButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 80, 40)];
    cancleButton.tag = 12;
    [cancleButton addTarget:self action:@selector(selectedCityTextFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setTitle:@"取消"  forState: UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor colorWithRed:88 / 255.0 green:233 / 255.0 blue:168 / 255.0 alpha:1] forState:UIControlStateNormal];
    [toolBar addSubview:cancleButton];
    
    UIButton *determineButton = [[UIButton alloc] initWithFrame:CGRectMake(Width - 80, 0, 80, 40)];
    determineButton.tag = 13;
    [determineButton addTarget:self action:@selector(selectedCityTextFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [determineButton setTitle:@"确定"  forState: UIControlStateNormal];
    [determineButton setTitleColor:[UIColor colorWithRed:82 / 255.0 green:208 / 255.0 blue:238 / 255.0 alpha:1] forState:UIControlStateNormal];
    [toolBar addSubview:determineButton];
    
    return toolBar;
}


/**
 *  辅助键盘按钮点击
 *
 *  @param sender 按钮
 */
- (void)selectedCityTextFieldDidChange:(UIButton *)sender{
    if (sender.tag == 13) {
        self.signTimeField.text = self.timeStr;
    }
    [self endEditing:YES];
}

/**
 *  懒加载时间选择器
 *
 *  @return 时间选择器
 */
- (UIDatePicker *)timePicker{
    if (!_timePicker) {
        _timePicker = [[UIDatePicker alloc] init];
        //        _timePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [_timePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
        
        //设置显示格式
        //默认根据手机本地设置显示为中文还是其他语言
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
        _timePicker.locale = locale;
        
        //当前时间创建NSDate
        NSDate *localDate = [NSDate date];
        //在当前时间加上的时间：格里高利历
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        //设置时间
        [offsetComponents setYear:0];
        [offsetComponents setMonth:0];
        [offsetComponents setDay:5];
        [offsetComponents setHour:20];
        [offsetComponents setMinute:0];
        [offsetComponents setSecond:0];
        //设置最大值时间
        NSDate *maxDate = [gregorian dateByAddingComponents:offsetComponents toDate:localDate options:0];
        //设置属性
        _timePicker.minimumDate = localDate;
        _timePicker.maximumDate = maxDate;
    }
    return _timePicker;
}

/**
 *  时间选择器的监听方法
 *  修改收货时间
 */
- (void)changeDate:(UIDatePicker *)datePick{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日(EEEE)   HH:mm:ss";
    self.timeStr = [formatter stringFromDate:datePick.date];
}

/**
 *  手势点击
 */
- (void)changeTimeClick:(UITapGestureRecognizer *)tap {
    [self.signTimeField becomeFirstResponder];
}


@end
