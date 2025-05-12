# Receipts Space API

[Receipts Space](https://www.receipts-app.com) is a product for macOS that automates document processing, by recognizing values and smart classifications.

Content of this repo:

- [Documentation](docs/index.md) (pre-rendered on the [web site](https://www.receipts-app.com/help/api.html))
- Examples
  - [Export](export) and [Import](import) via AppleScript and JavaScript
  - [Node JS](nodejs)
  - [Objective-C and Swift](objc)
  - [Shell](sh) for command line usage

> [!INFO]
> Also see [Technical Documentatio](https://receipts-app.com/docs) and [sample export](https://github.com/holtwick/receipts-space) for details about the file format.

## Changes

### 2.0.0 (2025-05-12)

- `providers` changed to `contacts`
- `json` is default export format, `ejson` and `plist` are deprecated, use `export <opts> as 'plist'` instead if you need them
- Changes in the data format
  - `provider` is now `contact`
  - New: `isDocument` is `1` if is document, `0` if is receipt
  - Asset: Checksum is now `sha1` instead of `md5`
  - Asset: `path` in not available anymore, use `url` instead
  - Asset: New `assetUrl` and `assetOriginalUrl` properties, see [docs](https://receipts-app.com/en/docs#assets) for details
  - Asset: New `type` holds MIME type of the asset

### 1.0.0

- Receipts 1.x API
