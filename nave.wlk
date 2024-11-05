import elementos.*
import vidas.*

object nave {
    var vidas = 3
    var property llaves = 0
    var property balasDisponibles = cantidadBalas
    const property cargador = []
    const property balasDisparadas = []

    method inicializarBalas(){
        const bala0 = new Bala(position = game.at(-1,-1))
        const bala1 = new Bala(position = game.at(-1,-1))
        const bala2 = new Bala(position = game.at(-1,-1))
        const bala3 = new Bala(position = game.at(-1,-1))
        const bala4 = new Bala(position = game.at(-1,-1))
        const bala5 = new Bala(position = game.at(-1,-1))
        const bala6 = new Bala(position = game.at(-1,-1))
        const bala7 = new Bala(position = game.at(-1,-1))
        const bala8 = new Bala(position = game.at(-1,-1))
        const bala9 = new Bala(position = game.at(-1,-1))

        cargador.add(bala0)
        cargador.add(bala1)
        cargador.add(bala2)
        cargador.add(bala3)
        cargador.add(bala4)
        cargador.add(bala5)
        cargador.add(bala6)
        cargador.add(bala7)
        cargador.add(bala8)
        cargador.add(bala9)

        game.addVisual(bala0)
        game.addVisual(bala1)
        game.addVisual(bala2)
        game.addVisual(bala3)
        game.addVisual(bala4)
        game.addVisual(bala5)
        game.addVisual(bala6)
        game.addVisual(bala7)
        game.addVisual(bala8)
        game.addVisual(bala9)
    }

    method dispararBala() {
        balasDisparadas.add(cargador.first())
        const bala = cargador.first()
        cargador.remove(cargador.first())
        return bala
    }

    method recuperarBala(miBala) {
        cargador.add(miBala)
        balasDisparadas.remove(miBala)
    }

    method tieneBalas() = cargador.size() > 0

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

    method consegurLlave() {llaves += 1}
    
    // GAME
    method image() = "nave.png"
    method colisionBala(bala){}
}

class Bala {
    var property position = game.at(anchoDelJuego/2,altoDelJuego)
    method image() = "bala.png"
    method colisionBala(bala){}
}