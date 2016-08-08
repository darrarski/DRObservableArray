//
// Created by Dariusz Rybicki on 08/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "CollectionViewUpdaterExampleViewController.h"

@implementation CollectionViewUpdaterExampleViewController

- (instancetype)init
{
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.title = @"Collection View Updater";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

@end
