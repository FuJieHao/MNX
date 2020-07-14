//
//  KTHorizontalScrollCell.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHorizontalScrollCell.h"
#import "NSAttributedString+CZAdditon.h"
#import "UILabel+CZAddition.h"
#import "KTscrollModel2.h"
#import "BuyView.h"

@interface KTHorizontalScrollCell ()<buyViewDelegate>
//设置可变数组后期设置约束用
@property (nonatomic,strong) NSMutableArray <UIView*>*btnArray;
@property (nonatomic,weak) UIScrollView *scView;
@property (nonatomic,weak) UIImageView *labelImageView;
@property (nonatomic,weak) UIImageView *imv;
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) NSMutableArray *priceArray;
@property (nonatomic,weak) NSArray *ImageAndLabelmodelArray;

@end


@implementation KTHorizontalScrollCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    //顶部的图片
    UIImageView *labelImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:labelImageView];
    //后期从网络加载图片
    //labelImageView.image = [UIImage imageNamed:@"user_default"];
    [labelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(35);
    }];
    self.labelImageView = labelImageView;
    
    
    UIScrollView *scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 38, [UIScreen mainScreen].bounds.size.width, 205)];
    [self.contentView addSubview:scView];
    self.scView = scView;
    [self setupBtn];
  }

- (void)setupBtn{
    //实力化
    self.imageArray = [NSMutableArray array];
    self.nameArray = [NSMutableArray array];
    self.priceArray = [NSMutableArray array];
    //加view 在view里放btn
    for (NSInteger i = 0; i < 5; i++) {
        UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(i * 120, 0, 120,   150)];
        //btnView.backgroundColor = [UIColor greenColor];
        [self.scView addSubview:btnView];
       // UIButton *btn = [self loadHomeTopBtnWithTitle:@"今日必备" andImageName:@"user_default" andIndex:i];
        [self.btnArray addObject:btnView];
        // NSLog(@"%@",self.modelArray[i].tname);
        //NSLog(@"%@",label);
        
    };
    
    self.scView.contentSize = CGSizeMake(self.btnArray.count*80, 0);
    //遍历数组 给每个view 上添加控件
    [self.btnArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imV = [[UIImageView alloc]init];
        //self.imv = imV;
       // imV.image = [UIImage imageNamed:@"user_default"];
        [self.imageArray addObject:imV];
        [obj addSubview:imV];
        [imV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(obj.mas_centerX);
            make.top.equalTo(obj.mas_top).offset(10);
            make.width.height.offset(90);
        }];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        [self.nameArray addObject:nameLabel];
        //nameLabel.text = @"xxx";
        [obj addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imV.mas_bottom).offset(10);
            //make.centerX.equalTo(imV.mas_centerX);
            make.left.offset(10);
            make.right.offset(-10);
        }];
        self.nameLabel = nameLabel;
             // 这个view来放价格和添加按钮
        UIView *priceView = [[UIView alloc]init];
        //priceView.backgroundColor = [UIColor yellowColor];
        [obj addSubview:priceView];
        //priceView.backgroundColor = [UIColor yellowColor];
        [priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(26);
            make.left.right.bottom.offset(0);
        }];
        
        //价格文字
        UILabel *priceLabel = [UILabel cz_labelWithText:@"1.2" fontSize:16 color:[UIColor blackColor]];
        [priceView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_left).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        [self.priceArray addObject:priceLabel];

        BuyView *addBtn = [[BuyView alloc]init];
        addBtn.btnTag = idx;
        addBtn.isDelete = YES;
        addBtn.delegate = self;
        [priceView addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.right.equalTo(imV.mas_right).offset(-10);
        }];
        
    }];

   }

#warning mark -- 代理方法 buyview
- (void)addGoods:(NSInteger)buyCount WithSender:(UIButton *)btn{

    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    
    KTscrollModel *model = self.modelScrollArray[self.cellTag];
    KTscrollModel2 *model2 = model.dataArray[btn.tag];
    
    
    NSDictionary *userInfo = @{
                               modelName:model2.long_name,
                               modelimgURL:model2.img,
                               modelPrice:model2.partner_price,
                               };
    
    [noti postNotificationName:modelNoti object:self userInfo:userInfo];


}


- (NSMutableArray <UIView*>*)btnArray{
    if (_btnArray == nil) {
       _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)setModelScrollArray:(NSArray<KTscrollModel *> *)modelScrollArray{
    _modelScrollArray = modelScrollArray;
    self.ImageAndLabelmodelArray = modelScrollArray;
    switch (self.cellTag) {
        case 1:
            [self setImageAndLabelWithCellTag:self.cellTag];
            break;
        case 2:
            [self setImageAndLabelWithCellTag:self.cellTag];
            break;
        case 3:
            [self setImageAndLabelWithCellTag:self.cellTag];
            break;
        default:
            break;
    }
}

- (void)setImageAndLabelWithCellTag:(NSInteger)cellTag{

    KTscrollModel *model = self.ImageAndLabelmodelArray[cellTag - 1];
    [self.labelImageView sd_setImageWithURL:[NSURL URLWithString:model.banner_img] placeholderImage:[UIImage imageNamed:@"user_default"]];
    
    
    [self.imageArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KTscrollModel2 *model2 =  model.dataArray[idx];
        [obj sd_setImageWithURL:[NSURL URLWithString:model2.img] placeholderImage:[UIImage imageNamed:@"user_default"]];
        if (cellTag == 3 && idx == 4) {
            [obj sd_setImageWithURL:[NSURL URLWithString:@"http://img01.bqstatic.com/upload/goods/201/609/2318/20160923180812_455433.jpg@200w_200h_90Q"] placeholderImage:[UIImage imageNamed:@"user_default"]];
        }
        obj.userInteractionEnabled = YES;
        UITapGestureRecognizer *panGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollJumpTo:)];
        [obj addGestureRecognizer:panGest];
    }];
    
    [self.nameArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KTscrollModel2 *model2 =  model.dataArray[idx];
        obj.text = model2.long_name;
        obj.font = [UIFont systemFontOfSize:12];
        obj.numberOfLines = 0;
        
        if (cellTag == 3 && idx == 4) {
            obj.text = @"你能看清算我的";
        }

        
    }];
    
    [self.priceArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KTscrollModel2 *model2 =  model.dataArray[idx];
        obj.text = [NSString stringWithFormat:@"$%@",model2.partner_price.description] ;
        //obj.font = [UIFont systemFontOfSize:13];
        [obj setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        obj.textColor = [UIColor redColor];
#warning mark - 扯淡的
        if (cellTag == 3 && idx == 0) {
            obj.text = @"$1.0";
        }
        if (cellTag == 3 && idx == 4) {
            obj.text = @"$88";
        }

        
    }];


}


- (void)scrollJumpTo:(UITapGestureRecognizer*)gesture{
    
    if (self.scrollBlock) {
        self.scrollBlock(gesture);
    }

}

@end
