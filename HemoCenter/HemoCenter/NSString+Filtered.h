//
//  NSString+Filtered.h
//  
//
//  Created by Txai Wieser on 6/17/15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Filtered)

+ (BOOL)isDigit:(unichar)c;
+ (NSString *)filteredPhoneStringFromString:(NSString *)string withFilter:(NSString *)filter;

@end
