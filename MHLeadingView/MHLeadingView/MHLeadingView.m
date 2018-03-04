//
//  MHLeadingView.m
//  MHLeadingView
//
//  Created by 徐茂怀 on 2018/3/2.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MHLeadingView.h"
#import "LeadingPageCell.h"
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface MHLeadingView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *_imageNames;
}
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIPageControl *pageControl;
@end
static NSString *const LeadingPageCellId = @"LeadingPageCellId";
@implementation MHLeadingView

-(instancetype)initWithImageNames:(NSArray *)imageNames
{
    self = [super init];
    if(self) {
        _imageNames = imageNames;
        [self _initSubViews];
    }
    return self;
}

-(void)_initSubViews{
    self.backgroundColor = [UIColor blueColor];
    self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LeadingPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LeadingPageCellId forIndexPath:indexPath];
    if (indexPath.row != _imageNames.count - 1) {
        cell.finishBtn.hidden = YES;
    }
    else {
        // 随后一页 显示按钮, 并且添加响应方法
        cell.finishBtn.hidden = NO;
        [cell.finishBtn addTarget:self action:@selector(finishBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.imageView.image = [UIImage imageNamed:_imageNames[indexPath.row]];
    return cell;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 向下取整
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[LeadingPageCell class] forCellWithReuseIdentifier:LeadingPageCellId];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = _imageNames.count;
        pageControl.currentPage = 0;
        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        CGSize pageControlSize = [pageControl sizeForNumberOfPages:_imageNames.count];
        CGFloat pageControlX = (self.bounds.size.width - pageControlSize.width)/2;
        // 距离屏幕下方为 50 请根据具体情况修改吧
        CGFloat pageControlY = (self.bounds.size.height - pageControlSize.height - 50.f);
        pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
        _pageControl = pageControl;
    }
    return _pageControl;
}

//动画可以在这里改
-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
         self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    } completion:nil];
}

-(void)finishBtnOnClick
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
