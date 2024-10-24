import elementos.*
object vidasNave {
    const x = anchoDelJuego - 5
    const y = altoDelJuego - 1.5
    const cant = 3
    var posUltVidaX = null
    var property listaVidas = [] 
     
    method agregarVidas() {
        (1..cant).forEach { i =>
            const vida = new Vida(ejeX = x + i, ejeY = y)
            listaVidas.add(vida) 
            game.addVisual(vida)
            posUltVidaX= vida.ejeX()
        }
    }
    
    method quitarVida() {
            const vida = listaVidas.last()  
            vida.quitarVida() 
            listaVidas.remove(vida)
            posUltVidaX= listaVidas.last().ejeX() 
    }

    method sumarVida() {
            const vida = new Vida(ejeX = posUltVidaX + 1, ejeY = y)
            listaVidas.add(vida)
            game.addVisual(vida)
            posUltVidaX = vida.ejeX()
    }
}

class Vida {
    const property ejeX 
    const ejeY
    const imagen = "vidaNave.png"
    
    method position() = game.at(ejeX, ejeY)
    method image() = imagen
    
    method quitarVida() {
        game.removeVisual(self)
    }
}