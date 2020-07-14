//
//  KTHomePageConvenientCell.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHomePageConvenientCell.h"
#import "KTHPConvenientListView.h"

#import "KTHPConvenientCollectionViewCell.h"

@interface KTHomePageConvenientCell () <UICollectionViewDataSource>

@property (nonatomic,weak) IBOutlet UIImageView *convenientImg;
@property (nonatomic,weak) IBOutlet UIImageView *cellImg;
@property (nonatomic,weak) IBOutlet UIImageView *discountImg;

@property (nonatomic,weak) IBOutlet KTHPConvenientListView *listView;

@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation KTHomePageConvenientCell

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KTHPConvenientCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.imgURL = self.model.collectionViewCell[indexPath.row];
    } else {
        cell.imgURL = self.model.collectionViewCell[indexPath.row + 2];
    }
    return cell;
}

- (void)awakeFromNib
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(self.contentView.frame.size.width / 2 - 1, (354 - (self.listView.frame.origin.y + self.listView.frame.size.height) - 1) / 2);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView setScrollEnabled:NO];
    collectionView.bounces = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:collectionView];
    collectionView.dataSource = self;
    
    self.collectionView = collectionView;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.listView.mas_bottom).offset(1);
        make.left.right.offset(0);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"KTHPConvenientCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
}

- (void)setModel:(KTHPConvenientModel *)model
{
    _model = model;
    
    [self.convenientImg sd_setImageWithURL:[NSURL URLWithString:model.convenientImg] placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
    [self.cellImg sd_setImageWithURL:[NSURL URLWithString:model.sellImg] placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
    [self.discountImg sd_setImageWithURL:[NSURL URLWithString:model.discountImg] placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
    
    self.listView.listViewDataSource = model.listViews;
}



@end
