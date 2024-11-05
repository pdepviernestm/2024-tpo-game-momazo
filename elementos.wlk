import vidas.*
const anchoDelJuego = 30
const altoDelJuego = 20
const tamanioCelda = 50
const maxMeteoritos = 12
const largoJefe = 6
const alturaBoss = 15
const cantidadBalas = 10
const rangoMovimiento = anchoDelJuego - largoJefe
const llavesNecesarias = 1

class ObjetoQueCae {
    var property position = game.at(1.randomUpTo(anchoDelJuego -4),15.randomUpTo(altoDelJuego-4))
    method posicionSpawn() {position = game.at(1.randomUpTo(anchoDelJuego-4),15.randomUpTo(altoDelJuego-4))}
    method image() 
    method esBeneficio()  
    method inicializarPosicion() {position = game.at(0, altoDelJuego + 1)}
}

class Meteorito inherits ObjetoQueCae() {
    // GAME
    override method esBeneficio() = false
    method serHiteado() {}
    override method image() = "meteorito.png"
    method afectar(nave){
        nave.modificarVida(-1)
        vidasNave.quitarVida()
    }
}

object medikit inherits ObjetoQueCae {
    override method esBeneficio() = true
    method serHiteado() {}
    override method image() = "medikit.png"
    
    method afectar(nave){
        if(nave.vidasNave() <3){
            nave.modificarVida(1)
            vidasNave.sumarVida()
        } 
    }
    
}

object llave inherits ObjetoQueCae { 
    override method image() = "llave.png"
    override method esBeneficio() = true
    method serHiteado() {} 
    method afectar(nave) {
        if(nave.llaves() < llavesNecesarias){
            nave.consegurLlave()
        }
    }
}

object cohete inherits ObjetoQueCae {
    method serHiteado() {}
    override method image() = "cohete.png"
    override method esBeneficio() = false

    method posicion(x,y){            
        position = game.at(x,y)
    }
    method afectar(nave){
        nave.morir()
    }
}


