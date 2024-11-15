import menu.*
import elementos.*
import vidas.*
import bossFinal.cerebroBoss
import contador.winOrLose

object nave {
    var vidas = 3
    var property llaves = 0
    var property disparoDisponible = 1
    var property contadorBalas = 0

    method cooldownDisparo() {
        disparoDisponible = 1
    }

    method dispararBala() {
        if (disparoDisponible == 1) {
            const balaActual = new Bala(position = self.position().up(1), numeroBala = contadorBalas) //spawnea arriba de la posicion actual de la nave 
            contadorBalas += 1
            game.addVisual(balaActual)
            disparoDisponible = 0
            soundtrack.efecto("BALA.mp3")
            balaActual.inicializar()
        }
    }

    method textColor() = "FF0000"

    method estaVivo() = vidas > 0
    
    method modificarVida(vidaModificada){
        vidas += vidaModificada
        if(vidas<=0){
            winOrLose.perdi()   
        }
    }
    method morir() {
        vidas = 0
        winOrLose.perdi()
    }
    
    method serAfectado(objeto) {
        objeto.afectar(self)
    }

    method estaMuerto() = vidas == 0
    method vidasNave() = vidas

    var property position = game.at(anchoDelJuego/2,1)

    method conseguirLlave() {
        llaves += 1
        self.verificarLLaves()
    }
    
    method verificarLLaves() {
      if (llaves == llavesNecesarias) {
        cerebroBoss.crearHitbox()
        llave.finalizar()
        }
    }

    // GAME
    method image() = "xwing.png"
    method colisionBala(bala){}
}

class Bala {
    var property position //= game.at(anchoDelJuego/2,altoDelJuego)
    var property nombreBala = ""
    const property numeroBala

    method image() = "bala.png"
    method colisionBala(bala){}
    method inicializar(){
        nombreBala = "BalaNumero".concat(numeroBala.stringValue())
        self.disparar()
    }
    method moverse() {
        self.position(self.position().up(1))
        if (position.y() >= altoDelJuego-4 ) {self.delete()}
    }
    method delete(){
        game.removeTickEvent(nombreBala) 
        game.removeVisual(self) 
    }
    method disparar(){
        game.onTick(100, nombreBala, {self.moverse()})
        game.onCollideDo(self, {elemento => elemento.colisionBala(self) })
    }
    
}