// (C)opyright 2017-04-25 Dirk Holtwick, holtwick.it. All rights reserved.

#import <Foundation/Foundation.h>

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    // Use AppleScript to export all receipts as plist
    NSString *source = @"tell application \"Receipts Space\" to export as plist";
    NSDictionary *error = nil;
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:source];
    NSString *string = [[appleScript executeAndReturnError:&error] stringValue];
    if (!string && error) {
      NSLog(@"Error %@", error);
      return -1;
    }
      
    // Convert the property list data to an NSDictionary
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id result = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:nil];
    
    // List all entries
    for (NSDictionary *receipt in result[@"items"]) {
      // NSLog(@"Receipt: %@", receipt);
      
      // Skip entries that are not a receipt, but a document
      if ([receipt[@"isDocument"] boolValue]) {
        NSLog(@"Skipping document %@", receipt[@"id"]);
        continue;
      }

      // Get the document file, which is always a PDF
      NSDictionary *asset = receipt[@"asset"];
      if (asset) {
        
        // The URL points to a local web server
        NSURL *url = [NSURL URLWithString:asset[@"url"]];
        NSLog(@"Asset URL: %@", url);
        NSData *data = [NSData dataWithContentsOfURL:url];

#error Set your own download path
        [data writeToFile:[NSString stringWithFormat:@"/Users/dirk/Downloads/%@.pdf", receipt[@"id"]] atomically:YES];
      }
    }
    
  }
  return 0;
}

