struct SerialCommand {
    // -- !: コマンドバッファのクリア。
    static let clear = "!"
    
    // -- A: 「リピート」をコマンドバッファに追加。
    static let repeatCommand = "A" // repeatは予約語で使えない
    
    /// -- B: 「点滅」をコマンドバッファに追加。
    static let blink = "B"
    
    // -- C: 「ヘッドライト」をコマンドバッファに追加。
    static let light = "C"
    
    // -- D: 「停止」をコマンドバッファに追加。
    static let stop = "D"
    
    // -- E: 「ゴール」をコマンドバッファに追加。
    static let goal = "E"
    
    // -- F: 「クラクション」をコマンドバッファに追加。
    static let horn = "F"
    
    // -- G: 「右」をコマンドバッファに追加。
    static let right = "G"
    
    /// -- H: 「後退」をコマンドバッファに追加。
    static let back = "H"
    
    /// -- I: 「左」をコマンドバッファに追加。
    static let left = "I"
    
    /// -- J: 「前進」をコマンドバッファに追加。
    static let forward = "J"
    
    /// -- h: LED の赤レベルを 0%に。
    static let ledRed0 = "h"
    
    /// -- i: LED の赤レベルを 33%に。
    static let ledRed33 = "i"
    
    /// -- j: LED の赤レベルを 67%に。
    static let ledRed67 = "j"
    
    /// -- k: LED の赤レベルを 100%に。
    static let ledRed100 = "k"
    
    /// -- l: LED の緑レベルを 0%に。
    static let ledGreen0 = "l"
    
    /// -- m: LED の緑レベルを 33%に。
    static let ledGreen33 = "m"
    
    /// -- n: LED の緑レベルを 67%に。
    static let ledGreen67 = "n"
    
    /// -- o: LED の緑レベルを 100%に。
    static let ledGreen100 = "o"
    
    /// -- p: LED の青レベルを 0%に。
    static let ledBlue0 = "p"
    
    /// -- q: LED の青レベルを 33%に。
    static let ledBlue33 = "q"
    
    /// -- r: LED の青レベルを 67%に。
    static let ledBlue67 = "r"
    
    /// -- s: LED の青レベルを 100%に。
    static let ledBlue100 = "s"
}
