
import Foundation

func train() {
    print("Vous entrez dans le mode d'entrainement")
    print("Avec quelle liste souhaitez vous vous entrainer ?")
    if var l = selectList(){
        
        if l.list.count != 0 {
            
            while true {
                let n = Int.random(in: 0...l.list.count-1)
                var e = l.list[n]
                print(e.i)
                let o = read()
                if o == "/qs" { l.save(); break } else
                if o == e.o{
                    print("Bonne réponse")
                    e.trial += 1
                    l.list[n] = e
                    print("Vous avez un ratio de: " + String( Double(e.trial - e.lose)/(Double(e.lose + 1)) ))
                    
                }else{
                    print("Mauvaise réponse")
                    print("La bonne réponse était: " + e.o)
                    
                    e.trial += 1
                    e.lose += 1
                    l.list[n] = e
                }
                
            }
        }else{
            print("Votre liste ne contient aucun mot, retour au menu")
        }
        
    }

    menu()
}