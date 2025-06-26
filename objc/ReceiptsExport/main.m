// (C)opyright 2017-04-25 Dirk Holtwick, holtwick.it. All rights reserved.

#import <Foundation/Foundation.h>

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSString *source = @"tell application \"Receipts Space\" to export as plist";
    NSDictionary *error = nil;
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:source];
    NSString *string = [[appleScript executeAndReturnError:&error] stringValue];
    if (!string && error) {
      NSLog(@"Error %@", error);
    } else {
      NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
      id result = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:nil];
      // List all assets
      for (NSDictionary *receipt in result[@"items"]) {
        NSDictionary *asset = receipt[@"asset"];
        if (asset) {
          NSURL *url = [NSURL URLWithString:asset[@"url"]];
          NSLog(@"Asset URL: %@", url);
          NSData *data = [NSData dataWithContentsOfURL:url];

#error Set your own download path
          [data writeToFile:[NSString stringWithFormat:@"/Users/dirk/Downloads/%@.pdf", receipt[@"id"]] atomically:YES];
        }
      }

      //      NSLog(@"%@", result);
    }
  }
  return 0;
}

//NSString* aScript = [NSString stringWithFormat: @"tell application \"Receipts\"\n set result to export where date paid from date \"%@\" to date \"%@\" as plist with paid and confirmed\n end tell",[aFormatter stringFromDate:self.startDate.dayStart],[aFormatter stringFromDate:self.endDate.dayEnd]];
//
//tell application "Receipts"
//set result to export where date paid from date "Thursday, 4. February 2021 at 00:00:00" to (current date) as plist with paid and confirmed
//end tell
