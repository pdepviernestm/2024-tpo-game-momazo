import vidas.*
const anchoDelJuego = 30
const altoDelJuego = 20
const tamanioCelda = 50
const maxMeteoritos = 15
const largoJefe = 6
const alturaBoss = 15
const cantidadBalas = 10
const rangoMovimiento = anchoDelJuego - largoJefe
const llavesNecesarias = 3

class ObjetoQueCae {
    var property position = game.at(1.randomUpTo(anchoDelJuego -4),15.randomUpTo(altoDelJuego-4))
    method posicionSpawn() {position = game.at(1.randomUpTo(anchoDelJuego-4),15.randomUpTo(altoDelJuego-4))}
    method image() 
    method inicializarPosicion() {position = game.at(0, altoDelJuego + 1)}
    // CORREGIR agregar colisionNave y despues usarlo con super
}

class Meteorito inherits ObjetoQueCae() {
    // GAME
    override method image() = "meteoritoFinal.png"
    method afectar(nave){
        nave.modificarVida(-1)
        vidasNave.quitarVida()
    }
    method colisionNave(nave){
        self.afectar(nave)
        game.sound("impacto.mp3").volume(0.1)
        game.sound("impacto.mp3").play()
        self.position(game.at(0,-1))
    }
    method colisionBala(bala){
        self.position(game.at(0,-1))
        bala.position(game.at(0,altoDelJuego+1))
    }    
}

object medikit inherits ObjetoQueCae {
    override method image() = "medikit.png"
    method afectar(nave){
        if(nave.vidasNave() <3){
            nave.modificarVida(1)
            vidasNave.sumarVida() //CORREGIR que la nave sume la vida
        } 
    }
    method colisionNave(nave){
        self.afectar(nave)
        game.sound("curacion.mp3").volume(0.1)
        game.sound("curacion.mp3").play()
        self.position(game.at(0,-1))
    }
    method colisionBala(bala){}
}

object llave inherits ObjetoQueCae { 
    override method image() = "llave.png"
    method afectar(nave) {
        if(nave.llaves() < llavesNecesarias){
            nave.consegurLlave()
        }
    }
    method colisionNave(nave){
        self.afectar(nave)
        game.sound("curacion.mp3").volume(0.1)
        game.sound("curacion.mp3").play()
        self.position(game.at(0,-1))
    }
    method colisionBala(bala){}
}

object cohete inherits ObjetoQueCae {
    override method image() = "cohete.png"
    method posicion(x,y){            
        position = game.at(x,y)
    }
    method afectar(nave){
        nave.morir()
    }
    method colisionNave(nave){
        self.afectar(nave)
        game.sound("impacto.mp3").volume(0.1)
        game.sound("impacto.mp3").play()
        self.position(game.at(0,-1))
    }
    method colisionBala(bala){
        self.position(game.at(0,-1))
        bala.position(game.at(0,altoDelJuego+1))
    }
}


