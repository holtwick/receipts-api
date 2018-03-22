// (C)opyright 2017-04-25 Dirk Holtwick, holtwick.it. All rights reserved.

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *source = @"tell application \"Receipts\" to export as plist";
        NSDictionary *error = nil;
        NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:source];
        NSString *string = [[appleScript executeAndReturnError:&error] stringValue];
        if (!string && error) {
            NSLog(@"Error %@", error);
        }
        else {
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            id result = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:nil];
            NSLog(@"%@", result);
        }
    }
    return 0;
}
