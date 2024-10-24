import vidas.*
const anchoDelJuego = 30
const altoDelJuego = 20
const tamanioCelda = 50
const maxMeteoritos = 18

class Meteorito {
    var position = game.at(1.randomUpTo(anchoDelJuego -3),15.randomUpTo(altoDelJuego-3))
    
    // GAME
    method position() = position
    method position(newPos) {
        position = newPos
    }
    method efecto() = "Danio"
    method esBeneficio() = false
    method posicionSpawn() {position = game.at(1.randomUpTo(anchoDelJuego-3),15.randomUpTo(altoDelJuego-3))} 
    method image() = "meteorito.png"
}
object puntaje {
    var puntos = 0

    method sumarPuntos() {
        puntos += 10
    }

    method restarPuntos() {
        if (puntos >= 100)
            puntos -= 100
        else
            puntos = 0
    }

    method text() = puntos.toString()
    method textColor() = "FFFFFF"
    method textSize() = 32

    // GAME
    var position = game.at(2, altoDelJuego - 2)

    method position() = position
    method position(newPos) {
        position = newPos
    }
}

object medikit {
    var position = game.at(2,altoDelJuego - 4)
    
    // GAME
    method esBeneficio() = true
    method position() = position
    method position(newPos) {
        position = newPos
    }
    method posicionSpawn() {position = game.at(1.randomUpTo(anchoDelJuego-1),15.randomUpTo(altoDelJuego-1))} 

    method efecto() = "Vida extra"
    method image() = "medikit.png"
}

object nave {
    var vidas = 3

    method textColor() = "FF0000"

    method estaVivo() = vidas > 0
    
    method modificarVida(vidaModificada){
        vidas += vidaModificada
    }
    method morir() {
        vidas = 0
    }
    
    method serAfectado(efecto) {
        if (efecto=="Vida extra" && vidas < 3){
            self.modificarVida(1)
            vidasNave.sumarVida()
        }
        else if (efecto=="Danio" && vidas > 0){
            self.modificarVida(-1)
            vidasNave.quitarVida()
        }
        else if (efecto=="Muerte"){
            self.morir()
        }
    }

    method estaMuerto() = vidas == 0

    var position = game.at(anchoDelJuego/2,1)
    
    // GAME
    method position() = position
    method position(newPosition) {
        position = newPosition
    }

    method image() = "nave.png"
}

object bala {
    var position = game.at(2,altoDelJuego)
    var cargada = true

    // GAME
    method position() = position
    method position(newPos) {
        position = newPos
    }
    
    method cargada() = cargada
    method cargada(estaCargada) {cargada = estaCargada} 

    method image() = "bala.png"
}

object cohete {
    var position = game.at(1.randomUpTo(anchoDelJuego-1),15.randomUpTo(altoDelJuego-1))

    // BASICO
    method image() = "cohete.png"

    method position() = position
    method position(newPosition) {
      position = newPosition
    }
    method esBeneficio() = false
    method efecto() = "Muerte"

    method posicion(x,y){            //Para poder pasar la posicicion con dos parametros
        position = game.at(x,y)
    }
}