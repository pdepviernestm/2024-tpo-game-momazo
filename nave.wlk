import elementos.*
import vidas.*

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
    
    method serAfectado(objeto) {
        objeto.afectar(self)
    }

    method estaMuerto() = vidas == 0
    method vidasNave() = vidas

    var property position = game.at(anchoDelJuego/2,1)
    
    // GAME
    method image() = "nave.png"
}

object bala {
    var property position = game.at(anchoDelJuego/2,altoDelJuego)
    var property cargada = true
    method image() = "bala.png"
}