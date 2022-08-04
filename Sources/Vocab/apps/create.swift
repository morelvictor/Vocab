
func create(){
    print("Vous vous apprétez à créer une nouvelle liste de vocabulaire")

    print("Comment voulez vous l'appeler ?")
    let title = read()

    print("Quelle est la langue d'origine ?")
    let li = selectLang()

    print("Quelle est la langue d'arrivée ?")
    let lo = selectLang()

    VList(title: title, langi: li, lango: lo, list: []).save()
    
    print("La liste a bien été crée, vous pouvez dès a présent la modifier pour ajouter des mots")
    print("Retour au menu")

    menu()
}