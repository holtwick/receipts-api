// Execute inside Apple's Script Editor

app = Application.currentApplication()
app.includeStandardAdditions = true

Receipts = new Application('Receipts Space')
if (Receipts) {

  // Get the data we want to export
  let jsonString = Receipts.export('items', {
    // mark: true,
    as: 'json',
  })
  let data = JSON.parse(jsonString)
  let items = data.items

  // let ctr = 0
  // Progress.totalUnitCount = items.length
  // Progress.description = 'Processing Items'

  let dest = app.chooseFolder()
  console.log('dest', dest)

  let str = $.NSString.alloc.initWithUTF8String(jsonString)
  str.writeToFileAtomically(`${dest}/Receipts.json`, true)

  for (let item of items) {

    // Create a custom file name
    let locale = 'de-de'
    let date = new Date(item.date).toLocaleDateString(locale)
    let amount = (+item.amountsOriginal.gross).toLocaleString(locale, {
      style: 'currency',
      currency: item.amountsOriginal.currency,
    })
    let provider = item.provider || { title: 'Unknown' }
    let fileName = `${provider.title}-${date}-${amount}-${item.id.slice(0, 4)}.pdf`

    // File URL to path
    let fileUrl = item.asset.url
    fileUrl = fileUrl.replace('file://', '')
    fileUrl = decodeURI(fileUrl)

    let script = `cp "${fileUrl}" "${dest}/${fileName}"`
    console.log(script)
    app.doShellScript(script)

    // console.log(fileName, item.url) 
    // Progress.completedUnitCount = ++ctr	
  }
}
else {
  console.error('Could not find Receipts')
}
