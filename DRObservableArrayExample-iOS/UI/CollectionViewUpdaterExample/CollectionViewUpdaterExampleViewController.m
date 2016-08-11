//
// Created by Dariusz Rybicki on 08/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "CollectionViewUpdaterExampleViewController.h"
#import "DRGenericObservableArray.h"
#import "DRObservableArrayCollectionViewUpdater.h"

@interface CollectionViewUpdaterExampleViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) id <DRObservableArray, DRObservableMutableArray> colors;
@property (nonatomic, strong) DRObservableArrayCollectionViewUpdater *colorsCollectionViewUpdater;

@end

@implementation CollectionViewUpdaterExampleViewController

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.title = @"Collection View Updater";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(shuffleButtonAction)];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.colors.observers addObserver:self.colorsCollectionViewUpdater];
}

#pragma mark - UI Actions

- (void)shuffleButtonAction
{
    [self shuffleColors];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIColor *color = ((NSArray *) [self.colors objectAtIndex:(NSUInteger) indexPath.row])[1];
    cell.contentView.backgroundColor = color;

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

#pragma mark - Colors

- (id <DRObservableArray, DRObservableMutableArray>)colors
{
    if (!_colors) {
        DRGenericObservableArray *colors = [[DRGenericObservableArray alloc] init];
        colors.objects = @[
            @[@1, [self colorWithHex:0xC0C0C0]],
            @[@2, [self colorWithHex:0x606060]],
            @[@3, [self colorWithHex:0x404040]],

            @[@4, [self colorWithHex:0xFF0000]],
            @[@5, [self colorWithHex:0x800000]],
            @[@6, [self colorWithHex:0x400000]],

            @[@7, [self colorWithHex:0xFFFF00]],
            @[@8, [self colorWithHex:0x808000]],
            @[@9, [self colorWithHex:0x404000]],

            @[@10, [self colorWithHex:0x00FF00]],
            @[@11, [self colorWithHex:0x008000]],
            @[@12, [self colorWithHex:0x004000]],

            @[@13, [self colorWithHex:0x00FFFF]],
            @[@14, [self colorWithHex:0x008080]],
            @[@15, [self colorWithHex:0x004040]],

            @[@16, [self colorWithHex:0x0000FF]],
            @[@17, [self colorWithHex:0x000080]],
            @[@18, [self colorWithHex:0x000040]],

            @[@19, [self colorWithHex:0xFF00FF]],
            @[@20, [self colorWithHex:0x800080]],
            @[@21, [self colorWithHex:0x400040]],
        ];
        _colors = colors;
    }
    return _colors;
}

- (UIColor *)colorWithHex:(NSInteger)hex
{
    return [UIColor colorWithRed:(CGFloat) (((float)((hex & 0xFF0000) >> 16)) / 255.0)
                           green:(CGFloat) (((float)((hex & 0xFF00) >> 8)) / 255.0)
                            blue:(CGFloat) (((float)(hex & 0xFF)) / 255.0)
                           alpha:1.0];
}

- (DRObservableArrayCollectionViewUpdater *)colorsCollectionViewUpdater
{
    if (!_colorsCollectionViewUpdater) {
        __weak typeof(self) welf = self;
        ObservableArrayCollectionViewUpdaterTableViewBlock collectionViewBlock = ^UICollectionView * {
            return welf.collectionView;
        };
        ObservableArrayCollectionViewUpdaterSectionBlock sectionBlock = ^NSUInteger {
            return 0;
        };
        _colorsCollectionViewUpdater = [[DRObservableArrayCollectionViewUpdater alloc] initWithCollectionViewBlock:collectionViewBlock
                                                                                                      sectionBlock:sectionBlock];
    }
    return _colorsCollectionViewUpdater;
}

- (void)shuffleColors
{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        NSUInteger count = self.colors.count;
        if (count < 1) return;
        for (NSUInteger index = 0; index < count - 1; ++index) {
            NSUInteger remainingCount = count - index;
            NSUInteger exchangeIndex = index + arc4random_uniform((u_int32_t )remainingCount);
            [self.colors exchangeObjectAtIndex:index withObjectAtIndex:exchangeIndex];
        }
    });
}

@end
