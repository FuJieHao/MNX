//
//  KTDetailsCell.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTDetailsCell.h"
#import "UILabel+CZAddition.h"
#import "NSAttributedString+CZAdditon.h"
#import "BuyView.h"
#define KAppViewW 112.5
#define KAPPViewH 140
#define KmarginY  2
//代表数据有多少列,或者一行上展现几个数据
#define KAppColCount 3

@interface KTDetailsCell ()<buyViewDelegate>
@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,weak) UIImageView *labelImageView;
@property (nonatomic,weak) UIImageView *imv;
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) NSMutableArray *priceArray;
@property (nonatomic,strong) NSMutableArray *bigDetailImageArray;
@property (nonatomic,strong) NSArray *imageAndLabelArray;


@end


@implementation KTDetailsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }

    return self;
}

- (void)setupUI{
    //实力化
    self.imageArray = [NSMutableArray array];
    self.nameArray = [NSMutableArray array];
    self.priceArray = [NSMutableArray array];
    self.bigDetailImageArray = [NSMutableArray array];

    UIImageView *detailImage = [[UIImageView alloc]init];
    detailImage.image = [UIImage imageNamed:@"icon_next"];
    [self.contentView addSubview:detailImage];
    [detailImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.left.offset(5);
        make.height.offset(20);
        make.width.offset(50);
    }];
    UIButton *moreBtn = [[UIButton alloc]init];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailImage.mas_top).offset(0);
        make.right.offset(-10);
        make.height.offset(20);
        make.width.offset(20);
    }];
    
    //图
    
    UIImageView *bigDetailImage = [[UIImageView alloc]init];
    //bigDetailImage.image = [UIImage imageNamed:@"user_default"];
    [self.contentView addSubview:bigDetailImage];
    [bigDetailImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailImage.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.offset(88);
    }];
    [self.bigDetailImageArray addObject:bigDetailImage];
    
    UIView *baseDetailView = [[UIView alloc]init];
    //baseDetailView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:baseDetailView];
    [baseDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bigDetailImage.mas_bottom).offset(20);
        make.left.offset(10);
        make.right.bottom.offset(-10);
    }];
    
    //九宫格布局
    
    //计算一个间隔
    // 界面宽- 控件的数量 *控件的宽度 / (控件的数量 +1)
    CGFloat marginX = ([UIScreen mainScreen].bounds.size.width - KAppColCount * KAppViewW)/ (KAppColCount + 1);
     //i小于多少的判断条件
    //有多少个数据
    for (int i = 0; i < 6; i ++ ) {
                //计算行
        int row = i / KAppColCount;
        //计算列
        int col = i % KAppColCount;
        //NSLog(@"%d",row);
        CGFloat appViewX  = 5 + col * (5 + KAppViewW) ;
        
       CGFloat appViewY = KmarginY + row * (KmarginY + KAPPViewH);
        
        UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(appViewX, appViewY, KAppViewW, KAPPViewH)];
        //detailView.backgroundColor = [UIColor greenColor];
        
        //1. 实例化控件
        [baseDetailView addSubview:detailView];
        
        [self.btnArray addObject:detailView];

        
        
    }
    
    [self.btnArray enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        UIImageView *imV = [[UIImageView alloc]init];
        //self.imv = imV;
         imV.image = [UIImage imageNamed:@"user_default"];
        [self.imageArray addObject:imV];
        [obj addSubview:imV];
        [imV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(obj.mas_centerX);
            make.top.equalTo(obj.mas_top).offset(10);
            make.left.equalTo(obj.mas_left).offset(5);
            make.right.equalTo(obj.mas_right).offset(-5);
            make.height.offset(70);
        }];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        [self.nameArray addObject:nameLabel];
        //nameLabel.text = @"xxx";
        [obj addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imV.mas_bottom).offset(5);
            //make.centerX.equalTo(imV.mas_centerX);
            make.left.offset(5);
            make.right.offset(-5);
        }];
        self.nameLabel = nameLabel;
        

        // 这个view来放价格和添加按钮
        UIView *priceView = [[UIView alloc]init];
        //priceView.backgroundColor = [UIColor yellowColor];
        [obj addSubview:priceView];
        [priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(26);
            make.left.right.bottom.offset(0);
        }];
        
     
        
        
        UILabel *priceLabel = [[UILabel alloc]init];
        //priceLabel.text = @"asd";
        [priceView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(obj.mas_left).offset(5);
            make.bottom.offset(-2);
        }];
        [self.priceArray addObject:priceLabel];
        
        
        BuyView *addBtn = [[BuyView alloc]init];
        addBtn.btnTag = idx;
        addBtn.delegate = self;
        addBtn.isDelete = YES;
        [priceView addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-2);
            make.right.offset(-5);
        }];
        
    }];

        

    
    




}


- (NSMutableArray *)btnArray{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }

    return _btnArray;
}

- (void)setDetailModelArray:(NSArray<KTdetailModel *> *)detailModelArray{
    _detailModelArray = detailModelArray;
    self.imageAndLabelArray = detailModelArray;
    NSLog(@"哈哈%ld",self.detailCellTag);
//    for (NSInteger i = 4; i<13; i++) {
//        [self setImageAndLabelWithDetailCellTag:i];
//    }
        switch (self.detailCellTag) {
        case 4:
            [self setImageAndLabelWithDetailCellTag:self.detailCellTag];
            break;
        case 5:
            [self setImageAndLabelWithDetailCellTag:self.detailCellTag];
            break;
        case 6:
            [self setImageAndLabelWithDetailCellTag:self.detailCellTag];
            break;
        case 7:
            [self setImageAndLabelWithDetailCellTag:self.detailCellTag];
            break;
        case 8:
            [self setImageAndLabelWithDetailCellTag:self.detailCellTag];
            break;
        case 9:
            [self setImageAndLabelWithDetailCellTag:self.detailCellTag];
            break;
        case 10:
            [self setImageAndLabelWithDetailCellTag:self.detailCellTag];
            break;
        case 11:
            [self setImageAndLabelWithDetailCellTag:self.detailCellTag];
            break;
        case 12:
            [self setImageAndLabelWithDetailCellTag:self.detailCellTag];
            break;
        default:
            break;
    }
}

- (void)detailJumpTo:(UITapGestureRecognizer*)sender{

    if (self.detailBlock) {
        self.detailBlock(sender);
    }

}

- (void)setImageAndLabelWithDetailCellTag:(NSInteger)detailCellTag{
    KTdetailModel *model = self.imageAndLabelArray[detailCellTag - 4];
    [self.imageArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KTdetailModel2 *model2 = model.dataArray[idx];
       // NSLog(@"图片樟树%ld",model.dataArray.count);
        [obj sd_setImageWithURL:[NSURL URLWithString:model2.img] placeholderImage:[UIImage imageNamed:@"user_default"]];
        
        //跳转
        if (self.reloadBlock) {
            self.reloadBlock(detailCellTag);
        }
        obj.userInteractionEnabled = YES;
        UITapGestureRecognizer *panGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailJumpTo:)];
        [obj addGestureRecognizer:panGest];
    }];
    
    [self.nameArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KTdetailModel2 *model2 =  model.dataArray[idx];
        obj.text = model2.long_name;
        obj.font = [UIFont systemFontOfSize:10];
        obj.numberOfLines = 0;
        if (model2.long_name.length > 30) {
            obj.text = @"[次日达]青岛大虾";
        }
        
    }];
    
    [self.priceArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KTdetailModel2 *model2 =  model.dataArray[idx];
        obj.text =[NSString stringWithFormat:@"$%@",@(model2.partner_price).description] ;
        obj.textColor = [UIColor redColor];
        [obj setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        obj.font = [UIFont systemFontOfSize:13];
        if (detailCellTag == 6 && idx == 5) {
            obj.text = @"$1.0";
        }else if (detailCellTag == 10 && idx == 3){
         obj.text = @"$1.0";
        }else if(detailCellTag == 11 && idx == 3){
         obj.text = @"$1.0";
        
        }else if (detailCellTag == 14 && idx == 3){
        
         obj.text = @"$1.0";
        }else if (detailCellTag == 17 && idx == 3){
        obj.text = @"$1.0";
        }
    }];
    
//    [self.bigDetailImageArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj sd_setImageWithURL:[NSURL URLWithString:model.banner_img] placeholderImage:[UIImage imageNamed:@"user_default"]];
//        if (idx == 2|| idx == 7|| idx == 10 || idx == 4) {
//           //        }
//        
//    }];
    if (model.banner_img.length > 0) {
         [self.bigDetailImageArray[0] sd_setImageWithURL:[NSURL URLWithString:model.banner_img] placeholderImage:[UIImage imageNamed:@"user_default"]];
    }else{
        [self.bigDetailImageArray[0] sd_setImageWithURL:[NSURL URLWithString:@"http://img01.bqstatic.com//upload/activity/cms_113589_1473842395.jpg@90Q.jpg"] placeholderImage:[UIImage imageNamed:@"user_default"]];

    }
    


}
- (void)setDetailCellTag:(NSInteger)detailCellTag{
    _detailCellTag = detailCellTag;
    

}

- (void)addGoods:(NSInteger)buyCount WithSender:(UIButton *)btn{
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    
    KTdetailModel *model = self.detailModelArray[self.detailCellTag];
    KTdetailModel2 *model2 = model.dataArray[btn.tag];
    
    
    NSDictionary *userInfo = @{
                               modelName:model2.long_name,
                               modelimgURL:model2.img,
                               modelPrice:@(model2.partner_price),
                               };
    
    [noti postNotificationName:modelNoti object:self userInfo:userInfo];
 

}
@end
