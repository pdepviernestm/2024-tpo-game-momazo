import vidas.*
const anchoDelJuego = 30
const altoDelJuego = 20
const tamanioCelda = 50
const maxMeteoritos = 12
const largoJefe = 6
const alturaBoss = 15
const rangoMovimiento = anchoDelJuego - largoJefe

class ObjetoQueCae {
 var property position = game.at(1.randomUpTo(anchoDelJuego -4),15.randomUpTo(altoDelJuego-4))
 method posicionSpawn() {position = game.at(1.randomUpTo(anchoDelJuego-4),15.randomUpTo(altoDelJuego-4))}
 method image() 
 method esBeneficio()  
}

class Meteorito inherits ObjetoQueCae() {
    // GAME
    override method esBeneficio() = false
    override method image() = "meteorito.png"
    method afectar(nave){
        nave.modificarVida(-1)
        vidasNave.quitarVida()
    }
}

object medikit inherits ObjetoQueCae {
    override method esBeneficio() = true
    override method image() = "medikit.png"
    
    method afectar(nave){
        if(nave.vidasNave() <3){
            nave.modificarVida(1)
            vidasNave.sumarVida()
        } 
    }
    
}

// object llave inherits Objeto{ 
//     method image() = "2.png"

//     method esBeneficio() = true
// }

object cohete inherits ObjetoQueCae {
    override method image() = "cohete.png"
    override method esBeneficio() = false

    method posicion(x,y){            
        position = game.at(x,y)
    }
    method afectar(nave){
        nave.morir()
    }
}


