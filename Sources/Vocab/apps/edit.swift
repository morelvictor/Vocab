import Foundation

func edit(){
    print("Vous entrez en mode édition")
    print("Quelle liste voulez vous modifier ?")
    
    if var list = selectList(){

        print("Vous modifiez la liste: " + list.title)

        ask(
            [
                ("Ajouter des mots", { addWords(&list) }),
                ("Sauvegarder et retourner au menu", { list.save(); menu() }),
                ("Supprimer la liste", { list.delete() })
            ]
        )
    }

    menu()
}

func addWords(_ l: UnsafePointer<VList>){
    var list = l.pointee

    while true{
        print(list.langi)
        let wi = read()
        if wi == "/stop" { list.save(); menu(); break }

        print(list.lango)
        let wo = read()
        if wo == "/stop" { list.save(); menu(); break }

        list.list.append(VWord(i: wi, o: wo, lose: 0, trial: 0))
    }
}