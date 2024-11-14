import elementos.*
class Digitos {
    var property digitoInteres //digito que nos importa del numero inicial 0 al 5 (6 totales 5-4-3-2-1-0)
    var property valorDigitoActual = 0
    var property imagen = "0.png"
    const property x
    const property y = 18

    method position() = game.at(x,y)
    method image() = imagen

    method actualizarValor(puntajeTotal) {
        valorDigitoActual = ((puntajeTotal/10 ** digitoInteres) % 10).truncate(0)
        self.actualizarImagen()
    }

    method actualizarImagen() { // valorDigitoActual.toString() + ".png"
       imagen = valorDigitoActual.toString() + ".png"
    }
}

object puntaje {
    const property digitos = []
    var puntos = 0

    method inicializar(){
        var contadorTemporal = 0
        6.times({_ => 
            const digitoActual = new Digitos(digitoInteres = contadorTemporal, x = 6 - contadorTemporal)
            digitos.add(digitoActual)
            game.addVisual(digitoActual)
            contadorTemporal +=1
        })
    }

    method sumarPuntos() {
        puntos += 10
        self.actualizarPuntaje()
    }

    method restarPuntos() {
        if (puntos >= 100)
            puntos -= 100
        else
            puntos = 0
        self.actualizarPuntaje()
    }

    method actualizarPuntaje() {
        digitos.forEach({a => a.actualizarValor(puntos)})
    }
}

object winOrLose {
    var property image = "2024-11-08-You-Win-.gif"

    const property position = game.at(9,7)

    method perdi() {
        self.image("2024-11-08-You-Lose-.gif")
        game.addVisual(self)
        game.schedule(100, {game.stop()}) 
    }

    method gane() {
        game.addVisual(self)
        game.schedule(100, {game.stop()}) 
    }
}