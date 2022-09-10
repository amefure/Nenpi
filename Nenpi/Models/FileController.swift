//
//  FileController.swift
//  Nenpi
//
//  Created by t&a on 2022/09/08.
//

import Foundation


// 請求金額を蓄積するためのFileController
class FileController {
    
    // Documents内で操作するJSONファイル名
    private let FileName:String = "NenpiData.json"
    // Documents内で追加できるロケーション数を格納
    private let txtName:String = "LimitNum.txt"
    // デフォルト制限数
    private let defaultLimit:String = "3"
    private let addLimitNum:Int = 3
    
    // 保存ファイルへのURLを作成 file::Documents/fileName
    func docURL(_ fileName:String) -> URL? {
        let fileManager = FileManager.default
        do {
            // Docmentsフォルダ
            let docsUrl = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            // URLを構築
            let url = docsUrl.appendingPathComponent(fileName)
            
            return url
        } catch {
            return nil
        }
    }
    // 操作するJsonファイルがあるかどうか
    func hasFile (_ fileName:String) -> Bool{
        let str =  NSHomeDirectory() + "/Documents/" + fileName
        if FileManager.default.fileExists(atPath: str) {
            return true
        }else{
            return false
        }
    }
    
    // 念の為数値かチェック
    private func numCheck (_ str:String) -> Bool{
        guard Int(str) != nil else {
            return false // 文字列の場合
        }
        return true // 数値の場合
    }
    
    // MARK: - NenpiData
    // ファイル削除処理
    func clearFile() {
        guard let url = docURL(FileName) else {
            return
        }
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
        }
    }
    
    // 登録する一件のキャッシュデータを受け取る
    // 現在のキャッシュALL情報を取得し構造体に変換してから追加
    // 再度JSONに直し書き込み
    func saveJson(_ data:NenpiData) {
        guard let url = docURL(FileName) else {
            return
        }
        
        var dataArray:[NenpiData]
        
        dataArray = loadJson() // [] or [NenpiData]
        dataArray.append(contentsOf: [data]) // いずれにせよ追加処理
        
        let encoder = JSONEncoder()
        let data = try! encoder.encode(dataArray)
        let jsonData = String(data:data, encoding: .utf8)!
        
        do {
            // ファイルパスへの保存
            let path = url.path
            try jsonData.write(toFile: path, atomically: true, encoding: .utf8)
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    func updateJson(_ allData:[NenpiData]) {
        guard let url = docURL(FileName) else {
            return
        }
        
        let encoder = JSONEncoder()
        let data = try! encoder.encode(allData)
        let jsonData = String(data:data, encoding: .utf8)!
        
        do {
            // ファイルパスへの保存
            let path = url.path
            try jsonData.write(toFile: path, atomically: true, encoding: .utf8)
        } catch let error as NSError {
            print(error)
        }
    }
    
    // JSONデータを読み込んで[構造体]にする
    func loadJson() -> [NenpiData] {
        guard let url = docURL(FileName) else {
            return []
        }
        if hasFile(FileName) {
            // JSONファイルが存在する場合
            let jsonData = try! String(contentsOf: url).data(using: .utf8)!
            let cashArray = try! JSONDecoder().decode([NenpiData].self, from: jsonData)
            return cashArray
        }else{
            // JSONファイルが存在しない場合
            return []
        }
    }
    // MARK: - NenpiData

    
    // LimitNum.txt---------------------------------------
    func loadLimitTxt() -> Int {
        
        guard let url = docURL(txtName) else {
            return Int(defaultLimit)!
        }
        
        do {
            if hasFile(txtName) {
                let currentLimit = try String(contentsOf: url, encoding: .utf8)
                
                if numCheck(currentLimit) {
                    return Int(currentLimit)!
                }else{
                    return Int(defaultLimit)!
                }
                
            }else{
                try defaultLimit.write(to: url,atomically: true,encoding: .utf8)
                return Int(defaultLimit)!
            }
            
        } catch{
            // JSONファイルが存在しない場合
            return Int(defaultLimit)!
        }
        
    }
    
    func addLimitTxt(){
        guard let url = docURL(txtName) else {
            return
        }
        do {
                var currentLimit = try String(contentsOf: url, encoding: .utf8)
                
                if numCheck(currentLimit) {
                    currentLimit = String(Int(currentLimit)! + addLimitNum)
                    try currentLimit.write(to: url,atomically: true,encoding: .utf8)
                }
            
        } catch{
            return
        }
        
    }
}

