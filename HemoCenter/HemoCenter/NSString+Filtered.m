//
//  NSString+Filtered.m
//  
//
//  Created by Txai Wieser on 6/17/15.
//
//

#import "NSString+Filtered.h"

@implementation NSString (Filtered)

+ (BOOL)isDigit:(unichar)c {
    NSCharacterSet *numericSet = [NSCharacterSet decimalDigitCharacterSet];
    if ([numericSet characterIsMember:c]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)filteredPhoneStringFromString:(NSString *)string withFilter:(NSString *)filter {
    
    NSUInteger onOriginal = 0, onFilter = 0, onOutput = 0;
    char outputString[([filter length])];
    BOOL done = NO;
    
    while(onFilter < [filter length] && !done)
    {
        char filterChar = [filter characterAtIndex:onFilter];
        char originalChar = onOriginal >= string.length ? '\0' : [string characterAtIndex:onOriginal];
        switch (filterChar) {
            case '#':
                if(originalChar=='\0')
                {
                    // We have no more input numbers for the filter.  We're done.
                    done = YES;
                    break;
                }
                if(isdigit(originalChar))
                {
                    outputString[onOutput] = originalChar;
                    onOriginal++;
                    onFilter++;
                    onOutput++;
                }
                else
                {
                    onOriginal++;
                }
                break;
            default:
                // Any other character will automatically be inserted for the user as they type (spaces, - etc..) or deleted as they delete if there are more numbers to come.
                outputString[onOutput] = filterChar;
                onOutput++;
                onFilter++;
                if(originalChar == filterChar)
                    onOriginal++;
                break;
        }
    }
    outputString[onOutput] = '\0'; // Cap the output string
    return [NSString stringWithUTF8String:outputString];
}

@end
