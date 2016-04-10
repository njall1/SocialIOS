//
//  SOLUserServiceImplementation.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLUserServiceImplementation.h"
#import "SOLUserService.h"

@implementation SOLUserServiceImplementation

- (void)updateUsersWithPredicate:(NSPredicate *)predicate completionBlock:(SOLUserCompletionBlock)completionBlock {
    
    typeof(self) __weak weakSelf = self;
    [_transport getFriendsWithCompletionBlopck:^(id data, NSError *error) {
        
        typeof(self) __strong strongSelf = weakSelf;
        if (completionBlock) {
            
            completionBlock([strongSelf.cache cacheExternalRepresentation:data mapper:strongSelf.mapper predicate:predicate], error);
        }
    }];
}

- (NSArray<SOLUserPlainObject *> *)obtainUsersWithPredicate:(NSPredicate *)predicate {
    
    return [_cache cacheWithPredicate:predicate mapper:_mapper];
}

@end
