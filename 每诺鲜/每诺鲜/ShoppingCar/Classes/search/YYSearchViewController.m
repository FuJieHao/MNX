//
//  YYSearchViewController.m
//  YYSearchView
//
//  Created by mac on 16/7/12.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import "YYSearchViewController.h"
#import "YYSearchView.h"
#import "YYCollectionCell.h"
#import "YYCoreData.h"
#import "YYHeaderView.h"
#import "YYFooterView.h"
#import "SearchHotModel.h"

static NSString * const ID = @"YYCollectionCell";
static NSString * const HeaderID = @"YYHeaderView";
static NSString * const FooterID = @"YYFooterView";
#define DefineWeakSelf __weak __typeof(self) weakSelf = self
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface YYSearchViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    YYSearchView * searchView;
}
@property(nonatomic,strong) NSMutableArray *historyArr;
@property(nonatomic,strong) NSMutableArray *hotArr;
@property(nonatomic,strong) NSMutableArray *hisTArr;

@end

@implementation YYSearchViewController

+(YYSearchViewController *)SearchViewController
{
    YYSearchViewController * search = [[YYSearchViewController alloc]initWithNibName:@"YYSearchViewController" bundle:nil];
    return search;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi"] forBarMetrics:UIBarMetricsDefault];
    [self setupData];
    [self setupSearchView];
    [self setupCollection];
}
-(void)setupData
{
    self.hisTArr = [NSMutableArray array];
    self.historyArr = [NSMutableArray arrayWithContentsOfFile:[[YYCoreData shareCoreData]userResPath:@"searchFile.plist"]];
    if (!self.historyArr) {
        self.historyArr = [NSMutableArray array];
    }
    for (NSDictionary * dict in self.historyArr)
    {
        [self.hisTArr addObject:[SearchHotModel cellModel:dict]];
    }
    self.hotArr = [NSMutableArray array];
    NSArray * titleArr = @[@{@"title":@"北京"},@{@"title":@"上海"},@{@"title":@"南昌"},@{@"title":@"cocoachina"}];
    for (NSDictionary * dict in titleArr)
    {
        [self.hotArr addObject:[SearchHotModel cellModel:dict]];
    }
    [self.YYCollectionView reloadData];
}
-(void)setupCollection
{
    self.YYCollectionView.delegate = self;
    self.YYCollectionView.dataSource = self;
    self.YYCollectionView.backgroundColor = [UIColor whiteColor];
    [self.YYCollectionView registerClass:[YYCollectionCell class] forCellWithReuseIdentifier:ID];
    [self.YYCollectionView registerNib:[UINib nibWithNibName:@"YYHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    [self.YYCollectionView registerNib:[UINib nibWithNibName:@"YYFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID];
}

-(void)setupSearchView
{
    searchView = [YYSearchView creatView];
    searchView.frame = CGRectMake(0, 0, ScreenWidth, 40);
    searchView.YYSearch.delegate = self;
    DefineWeakSelf;
    [searchView setYYGetCancel:^{
        
    }];
    [searchView setYYGetTitle:^(NSString * title)
    {
        [weakSelf searchKeyWords:title];
    }];
    self.navigationItem.titleView = searchView;
}

-(void)searchKeyWords:(NSString *)keyWords
{
    if ([keyWords isEqualToString:@""] || keyWords == nil)
    {
        return;
    }
    [self loadSearchDataWithKeyWord:keyWords];
}

- (void)loadSearchDataWithKeyWord:(NSString *)keyword
{
    for (int i = 0; i< self.historyArr.count; i++)
    {
        if ([[self.historyArr[i] valueForKey:@"title"] isEqual:keyword] == YES)
        {
            [self.historyArr removeObject:self.historyArr[i]];
        }
    }
    NSDictionary * dict2 = @{@"title":keyword};
    [self.historyArr addObject:dict2];
    //写入本地
    NSString *path = [[YYCoreData shareCoreData] userResPath:@"searchFile.plist"];
    [self.historyArr writeToFile:path atomically:YES];
    
    self.hisTArr = [NSMutableArray array];
    self.historyArr = [NSMutableArray arrayWithContentsOfFile:[[YYCoreData shareCoreData]userResPath:@"searchFile.plist"]];
    if (!self.historyArr)
    {
        self.historyArr = [NSMutableArray array];
    }
    for (NSDictionary * dict in self.historyArr)
    {
        [self.hisTArr addObject:[SearchHotModel cellModel:dict]];
    }
    [self.YYCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.historyArr.count <= 0)
    {
        return 1;
    }
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.historyArr.count <= 0)
    {
        return self.hotArr.count;
    }else
    {
        if (section == 0)
        {
            return self.historyArr.count;
        }
        return self.hotArr.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (self.historyArr.count <= 0)
    {
        SearchHotModel * model = self.hotArr[indexPath.row];
        [cell cellModel:model];
    }else
    {
        if (indexPath.section == 0)
        {
            SearchHotModel * model = self.hisTArr[indexPath.row];
            [cell cellModel:model];
        }else
        {
            SearchHotModel * model = self.hotArr[indexPath.row];
            [cell cellModel:model];
        }
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView cellForItemAtIndexPath:indexPath];
    if (self.historyArr.count <= 0)
    {
        SearchHotModel * model = self.hotArr[indexPath.row];
        searchView.YYSearch.text = model.title;
        searchView.YYSearch.tag = model.id;
    }else
    {
        if (indexPath.section == 1)
        {
            SearchHotModel * model = self.hotArr[indexPath.row];
            searchView.YYSearch.text = model.title;
            searchView.YYSearch.tag = model.id;
        }else
        {
            SearchHotModel * model = self.hisTArr[indexPath.row];
            searchView.YYSearch.text = model.title;
            searchView.YYSearch.tag = model.id;
        }
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (self.historyArr.count > 0)
    {
        if ([kind isEqual:UICollectionElementKindSectionFooter])
        {
            YYFooterView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID forIndexPath:indexPath];
            DefineWeakSelf;
            [footer setYYCleanBut:^{
                [weakSelf clearHistoryRecords];
            }];
            return footer;
        }
    }
    
    YYHeaderView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
    if (self.historyArr.count <= 0)
    {
        [header titleHeader:@[@"热门搜索"][indexPath.section]];
    }else
    {
        [header titleHeader:@[@"历史搜索",@"热门搜索"][indexPath.section]];
    }
    return header;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenWidth, 40.0f);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return CGSizeMake(ScreenWidth, 50.0f);
    }
    return CGSizeMake(0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3.0f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYCollectionCell * cell = [[YYCollectionCell alloc]init];
    if (self.historyArr.count <= 0)
    {
        SearchHotModel * model = self.hotArr[indexPath.row];
        [cell cellModel:model];
        [cell layoutIfNeeded];
        CGRect frame = cell.frame;
        return frame.size;
    }else
    {
        if (indexPath.section == 1)
        {
            SearchHotModel * model = self.hotArr[indexPath.row];
            [cell cellModel:model];
            [cell layoutIfNeeded];
            CGRect frame = cell.frame;
            return frame.size;
        }else
        {
            SearchHotModel * model = self.hisTArr[indexPath.row];
            [cell cellModel:model];
            [cell layoutIfNeeded];
            CGRect frame = cell.frame;
            return frame.size;
        }
    }
    return CGSizeMake(0, 0);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,5,5,5);
}
- (void)clearHistoryRecords
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要清空历史记录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.historyArr removeAllObjects];
        NSString *path = [[YYCoreData shareCoreData] userResPath:@"searchFile.plist"];
        [self.historyArr writeToFile:path atomically:YES];
        [self.YYCollectionView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
