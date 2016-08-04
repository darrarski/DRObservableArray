//
//  Created by Dariusz Rybicki on 04/08/16.
//  Copyright © 2016 Darrarski. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (instancetype)init
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.title = @"DRObservableArrayExample";
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
