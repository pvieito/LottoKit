# LottoKit

Swift framework and CLI tool to check tickets from the Spanish Christmas Lottery.

## Requirements

`LottoKit` requires **Swift 5** or higher and has been tested both on macOS and Linux.

## Usage

To check the lottery tickets against the Christmas Lottery results, simply feed the numbers:

```console
$ cd LottoKit
$ swift run LottoTool -i 03347 21015 04211
[*] 03347: 400000.0€
[*] 21015: 125000.0€
[*] 04211: 50000.0€
```

You can also use `LottoTool` to check “El Niño” lottery results:

```console
$ swift run LottoTool -i 03347 21015 04211 -m ElNiño
```

## Notes

`LottoKit` uses the [_El País_ Christmas Lottery API](https://servicios.elpais.com/sorteos/loteria-navidad/api/) as its backend. Always double-check the result with the official [Loterías y Apuestas del Estado](https://www.loteriasyapuestas.es/es/loteria-nacional) list.
