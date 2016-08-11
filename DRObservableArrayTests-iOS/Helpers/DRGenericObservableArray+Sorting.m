//
// Created by Dariusz Rybicki on 12/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "DRGenericObservableArray+Sorting.h"

@implementation DRGenericObservableArray (Sorting)

- (void)bubbleSort
{
    NSUInteger n = self.count;
    while (n > 1) {
        for (NSUInteger i = 0; i < n - 1; i++) {
            id current = [self objectAtIndex:i];
            id next = [self objectAtIndex:i + 1];
            assert([current respondsToSelector:@selector(compare:)]);
            assert([next respondsToSelector:@selector(compare:)]);
            NSComparisonResult result = (NSComparisonResult) [current performSelector:@selector(compare:) withObject:next];
            if (result == NSOrderedDescending) {
                [self exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
            }
        }
        n--;
    }
}

@end
