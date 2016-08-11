//
//  Created by Dariusz Rybicki on 04/08/16.
//  Copyright © 2016 Darrarski. All rights reserved.
//

#import "TableViewUpdaterExampleViewController.h"
#import "DRGenericObservableArray.h"
#import "DRObservableArrayTableViewUpdater.h"

@interface TableViewUpdaterExampleViewController ()

@property (nonatomic, strong) id <DRObservableArray, DRObservableMutableArray> words;
@property (nonatomic, strong) DRObservableArrayTableViewUpdater *wordsTableViewUpdater;

@end

@implementation TableViewUpdaterExampleViewController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        self.title = @"Table View Updater";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(shuffleButtonAction)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.words.observers addObserver:self.wordsTableViewUpdater];
}

#pragma mark - UI Actions

- (void)shuffleButtonAction
{
    [self shuffleWords];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.words.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *word = [self.words objectAtIndex:(NSUInteger) indexPath.row][1];
    cell.textLabel.text = word;

    return cell;
}

#pragma mark - Words

- (id <DRObservableArray, DRObservableMutableArray>)words
{
    if (!_words) {
        DRGenericObservableArray *words = [[DRGenericObservableArray alloc] init];
        words.objects = @[
            @[@1, @"jat"], @[@2, @"wise"], @[@3, @"genit"], @[@4, @"file"], @[@5, @"straw"],
            @[@6, @"cow"], @[@7, @"sleuth"], @[@8, @"lunes"], @[@9, @"scan"], @[@10, @"gyn"],
            @[@11, @"luce"], @[@12, @"weft"], @[@13, @"bim"], @[@14, @"moit"], @[@15, @"wrench"],
            @[@16, @"kempt"], @[@17, @"klepht"], @[@18, @"whiz"], @[@19, @"prawn"], @[@20, @"crud"]
        ];
        _words = words;
    }
    return _words;
}

- (DRObservableArrayTableViewUpdater *)wordsTableViewUpdater
{
    if (!_wordsTableViewUpdater) {
        __weak typeof(self) welf = self;
        ObservableArrayTableViewUpdaterTableViewBlock tableViewBlock = ^UITableView * {
            return welf.tableView;
        };
        ObservableArrayTableViewUpdaterSectionBlock sectionBlock = ^NSUInteger {
            return 0;
        };
        _wordsTableViewUpdater = [[DRObservableArrayTableViewUpdater alloc] initWithTableViewBlock:tableViewBlock
                                                                                      sectionBlock:sectionBlock];
    }
    return _wordsTableViewUpdater;
}

- (void)shuffleWords
{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        NSUInteger count = self.words.count;
        if (count < 1) return;
        for (NSUInteger index = 0; index < count - 1; ++index) {
            NSUInteger remainingCount = count - index;
            NSUInteger exchangeIndex = index + arc4random_uniform((u_int32_t )remainingCount);
            [self.words exchangeObjectAtIndex:index withObjectAtIndex:exchangeIndex];
        }
    });
}

@end
