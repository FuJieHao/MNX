//
//  KTHomePageOtherCell.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHomePageOtherCell.h"
#import "KTHPOtherGoodsCollectionCell.h"
#import "CZAdditions.h"
#import "KTHPWebViewController.h"

@interface KTHomePageOtherCell () <UICollectionViewDataSource>

@property (nonatomic,weak) IBOutlet UILabel *topLabel;
@property (nonatomic,weak) IBOutlet UIImageView *topImage;
@property (nonatomic,weak) IBOutlet UIView *topView;
@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation KTHomePageOtherCell

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KTHPOtherGoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCell" forIndexPath:indexPath];
    
    cell.model = self.model.arrModel[indexPath.row];
    
    return cell;
}


- (void)awakeFromNib
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    layout.itemSize = CGSizeMake(self.contentView.frame.size.width / 3 - 3, (340 - (self.topImage.frame.origin.y + self.topImage.frame.size.height) - 1));
    
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.bounces = NO;
    [collectionView setScrollEnabled:NO];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:collectionView];
    collectionView.dataSource = self;
    
    self.collectionView = collectionView;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImage.mas_bottom).offset(1);
        make.left.right.offset(0);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"KTHPOtherGoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsCell"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToWebVC:)];
    self.topImage.userInteractionEnabled = YES;
    [self.topImage addGestureRecognizer:tap];
    
}

- (void)goToWebVC:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(homePageOtherCell:andTopString:)]) {
        [self.delegate homePageOtherCell:self andTopString:self.topLabel.text];
    }
    
}

- (void)setModel:(KTHPOtherModel *)model
{
    _model = model;
    self.topLabel.text = model.name;
    NSString *colorStr = [NSString stringWithFormat:@"0x%d",model.category_color];

    self.topLabel.textColor = [UIColor cz_colorWithHex:(uint32_t)colorStr];
    self.topView.backgroundColor = [UIColor cz_colorWithHex:(uint32_t)colorStr];
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:model.topImg] placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
    [self.collectionView reloadData];
}

@end
