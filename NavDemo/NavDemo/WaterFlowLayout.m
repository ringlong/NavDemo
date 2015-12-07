//
//  WaterFlowLayout.m
//  NavDemo
//
//  Created by Ryan on 15/5/22.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "WaterFlowLayout.h"
@interface WaterFlowLayout ()

@property (nonatomic, strong) NSMutableDictionary *attributesDict;
@property (nonatomic, strong) NSMutableArray *columnArray;
@property (nonatomic, assign) NSInteger cellCount;

@end

@implementation WaterFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.attributesDict = [NSMutableDictionary dictionaryWithCapacity:0];
    self.columnArray = @[@0, @0, @0].mutableCopy;
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
    if (self.cellCount == 0) {
        return;
    }
    for (NSInteger i = 0; i < self.cellCount; i++) {
        [self layoutForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    
}

- (void)layoutForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.item];
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    
    __block NSInteger column = 0;
    __block CGFloat shortHeight = [self.columnArray[column] floatValue];
    [self.columnArray enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        if (obj.floatValue < shortHeight) {
            shortHeight = obj.floatValue;
            column = idx;
        }
    }];
    CGFloat top = [self.columnArray[column] floatValue];
    CGRect frame = CGRectMake(edgeInsets.left + column * (edgeInsets.left + itemSize.width), top + edgeInsets.top, itemSize.width, itemSize.height);
    
    [self.columnArray replaceObjectAtIndex:column withObject:@(top + edgeInsets.top + itemSize.height)];
    self.attributesDict[NSStringFromCGRect(frame)] = indexPath;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:0];
    for (NSString *rectString in self.attributesDict) {
        CGRect cellRect = CGRectFromString(rectString);
        if (CGRectIntersectsRect(rect, cellRect)) {
            NSIndexPath *indexPath = self.attributesDict[rectString];
            [indexPaths addObject:indexPath];
        }
    }
    return indexPaths;
}

- (CGSize)collectionViewContentSize {
    CGSize size = self.collectionView.frame.size;
    [self.columnArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return obj1.floatValue < obj2.floatValue;
    }];
    size.height = [self.columnArray.lastObject floatValue];
    return size;
}
    
    
@end
