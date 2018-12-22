#  LottoKit

Swift framework and CLI tool to check lottery tickets from Spanish Christmas Lottery.

## Requirements

`LottoKit` requires **Swift 4.2** or higher and has been tested both on macOS and Linux.

## Usage

To check the lottery tickets agains the Chrismast Lottery results simply feed the numbers:

```
$ cd LottoKit
$ swift run LottoTool -i 03347 21015 04211
[*] 03347: 400000.0€
[*] 21015: 125000.0€
[*] 04211: 50000.0€
```

You can also use `LottoTool` to check “El Niño” Lottery results:

```
$ swift run LottoTool -i 03347 21015 04211 -m ElNiño
```

## Notes

 `LottoKit` uses [_El País_ Christmas Lottery API](https://servicios.elpais.com/sorteos/loteria-navidad/api/) as its backend. Always double check the result with the official [ONLAE](https://www.loteriasyapuestas.es/es/loteria-nacional) list.
