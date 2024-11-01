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

    method actualizarImagen() {
        if (valorDigitoActual == 0) { imagen = "0.png" }
        if (valorDigitoActual == 1) { imagen = "1.png" }
        if (valorDigitoActual == 2) { imagen = "2.png" }
        if (valorDigitoActual == 3) { imagen = "3.png" }
        if (valorDigitoActual == 4) { imagen = "4.png" }
        if (valorDigitoActual == 5) { imagen = "5.png" }
        if (valorDigitoActual == 6) { imagen = "6.png" }
        if (valorDigitoActual == 7) { imagen = "7.png" }
        if (valorDigitoActual == 8) { imagen = "8.png" }
        if (valorDigitoActual == 9) { imagen = "9.png" }
    }
}

object puntaje {
    const property digitos = []
    var puntos = 0

    method inicializar(){
        const digito0 = new Digitos(digitoInteres = 0, x = 6) 
        const digito1 = new Digitos(digitoInteres = 1, x = 5)
        const digito2 = new Digitos(digitoInteres = 2, x = 4)
        const digito3 = new Digitos(digitoInteres = 3, x = 3)
        const digito4 = new Digitos(digitoInteres = 4, x = 2)
        const digito5 = new Digitos(digitoInteres = 5, x = 1)
        digitos.add(digito0)
        digitos.add(digito1)
        digitos.add(digito2)
        digitos.add(digito3)
        digitos.add(digito4)
        digitos.add(digito5)
        game.addVisual(digito0)
        game.addVisual(digito1)
        game.addVisual(digito2)
        game.addVisual(digito3)
        game.addVisual(digito4)
        game.addVisual(digito5)
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

object cargadorContador {
    const property digitos = []
    var balas = cantidadBalas

    method inicializar(){
        const digito0 = new Digitos(digitoInteres = 0, x = 29, y=0) 
        const digito1 = new Digitos(digitoInteres = 1, x = 28, y=0)
        digitos.add(digito0)
        digitos.add(digito1)
        self.actualizarCargador()
        game.addVisual(digito0)
        game.addVisual(digito1)
    }

    method cargarBala() {
        balas += 1
        self.actualizarCargador()
    }

    method gastarBala() {
        balas -= 1
        self.actualizarCargador()
    }

    method actualizarCargador() {
        digitos.forEach({a => a.actualizarValor(balas)})
    }
}