import Foundation

func menu(){
    print("Vous êtes dans le menu, quelle application voulez vous utiliser?")
    ask(
        [
            ("Entrainement", {train()}), 
            ("Edition", { edit() }),
            ("Créer une liste", { create() }),
            ("Quitter",  {exit(0)})
        ])
    
}
