import Foundation

func read() -> String {
    if let r = readLine() {

        switch r {
        case "/menu":
            menu()
        case "/edit":
            edit()
        case "/train":
            train()
        default:
            break
        }
        
        return r
    }else {
        return read()
    } 
}

func ask(_ actions: [( String, (() -> Void))]){
    if(actions.count == 0) {return}

    for i in 0...(actions.count - 1) {
        print(" " + String(i+1) + " - " + actions[i].0)
    }

    var valid = false

    while !valid {
        if let c = Int(read())  {
            if c > 0 && c <= actions.count {
                valid = true
                actions[c-1].1()
            }
            
        }
    }
    
}

func selectList() -> VList?{

    var acc: VList? = nil

    do{
        let availableLists = try FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)
        

        var act: [( String, () -> ())] = []

        availableLists.forEach(){ e in
            
            if e.pathComponents.last?.split(separator: ".").last == "json" {
                let filename = e.pathComponents.last?.split(separator: ".").first
                act.append(contentsOf: [(String(filename!), { acc = (load(String(filename!))) })] ) 
                
            }
            
        }
        
        ask(act)
    
    }catch{
        fatalError()
    }

    return acc
}

func selectLang() -> VLang{
    var acc: VLang? = nil
    let availableLists = VLang.allCases
    

    var act: [( String, () -> ())] = []

    availableLists.forEach(){ e in
        act.append(contentsOf: [(e.description, { acc = (e) })] ) 
    }
    
    ask(act)
    return acc!
}