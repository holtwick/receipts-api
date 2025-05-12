// (C)opyright 2017-04-25 Dirk Holtwick, holtwick.it. All rights reserved.

// https://github.com/TooTallNate/node-applescript

var applescript = require('applescript')

// Very basic AppleScript command. Returns the song name of each
// currently selected track in iTunes as an 'Array' of 'String's.
var script = 'tell application "Receipts Space" to export as json'

applescript.execString(script, function (err, rtn) {
  if (err) {
    console.log(err)
    return
  }
  let data = JSON.parse(rtn)
  data.items.forEach(function (item) {
    console.log(
      item.date ? item.date.slice(0, 10) : '?',
      item.amounts.gross,
      item.amounts.currency,
      item.provider ? item.provider.title : '?'
    )
  })
})
