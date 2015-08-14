//
//  WaterFallViewController.m
//  NavDemo
//
//  Created by Ryan on 15/5/22.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "WaterFallViewController.h"
#import "WaterFlowLayout.h"
#import "WaterCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RRToolkit.h"

static NSString *WaterCellIdentifier = @"water";

@interface WaterFallViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation WaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WaterFlowLayout *flowLayout = [[WaterFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[WaterCollectionViewCell class] forCellWithReuseIdentifier:WaterCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self imageArray];
    [self.collectionView reloadData];
}

#pragma mark - 数据

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithCapacity:10];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group) {
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if (result) {
                        ALAssetRepresentation *resentation = [result defaultRepresentation];
                        CGImageRef imageRef = resentation.fullResolutionImage;
                        UIImage *image = [UIImage imageWithCGImage:imageRef];
                        
                        [_imageArray addObject:image];
                    }
                }];
            }
            *stop = YES;
            if (*stop == YES) {
                [self.collectionView reloadData];
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    return _imageArray;
}

#pragma mark - Private Methods

- (CGFloat)imageHight:(UIImage *)image {
    return image.size.height / image.size.width * ((self.view.width - 4 * 5) / 3);
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%@", self.imageArray);
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterCellIdentifier forIndexPath:indexPath];
    
    cell.image = self.imageArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = self.imageArray[indexPath.item];
    CGFloat height = [self imageHight:image];
    return CGSizeMake((self.view.width - 4 * 5) / 3, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
