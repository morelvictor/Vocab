
import Foundation

let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent("Vocab", isDirectory: true)
                    .appendingPathComponent("Datas", isDirectory: true)


func load<T: Decodable>(_ filename: String) -> T {
    do {try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)}catch{fatalError()}

    let data: Data

    let file = dir.appendingPathComponent( filename + ".json")

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

extension VList {
    
    func save() {
        do {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)

            let encoder = JSONEncoder()
            let data =  try encoder.encode(self)
            let str = String(data: data, encoding: .utf8)!
            let url = dir.appendingPathComponent(title + ".json")
            
            try str.write(to: url, atomically: false, encoding: .utf8)
            print("La liste " + title + " vient d'être sauvegardée")
            
        }catch{fatalError()}
    }

    func delete(){
        do {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)

            let url = dir.appendingPathComponent(title + ".json")

            try FileManager.default.removeItem(at: url)
            print("La liste " + title + " a bien été suprimmée.")
            
        }catch{fatalError()}
    }
    
}