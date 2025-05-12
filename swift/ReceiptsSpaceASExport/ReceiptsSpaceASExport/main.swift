import Foundation

func executeAppleScript() {
  // Define the AppleScript command
  let script = "tell application \"Receipts Space\" to export as json"

  // Create an NSAppleScript instance with the script
  guard let appleScript = NSAppleScript(source: script) else {
    print("Failed to create AppleScript instance.")
    return
  }

  // Execute the script and capture the result
  var error: NSDictionary?
  let result = appleScript.executeAndReturnError(&error)
  print("Result: \(result.stringValue ?? "No Value")") 
}

executeAppleScript()
