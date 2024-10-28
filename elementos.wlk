import vidas.*
const anchoDelJuego = 30
const altoDelJuego = 20
const tamanioCelda = 50
const maxMeteoritos = 0
const largoJefe = 6
const alturaBoss = 15
const rangoMovimiento = anchoDelJuego - largoJefe

// class Objeto {
//  var property position = game.at(1.randomUpTo(anchoDelJuego -3),15.randomUpTo(altoDelJuego-3))
//  method posicionSpawn() {position = game.at(1.randomUpTo(anchoDelJuego-3),15.randomUpTo(altoDelJuego-3))}
//  method image() //Método abstracto
//  method esBeneficio()  //Método abstracto
// }


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

// object llave inherits Objeto{ 
//     method image() = "2.png"

//     method esBeneficio() = true
// }

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


object cerebroBoss {
    var property vida = 100
    const hitbox = []
    var property direccion = true // false izq true der
    var property contadorMovimiento = 0

    method esBeneficio() = true

    method agregarHitbox (elementoHitbox) {
        hitbox.add(elementoHitbox)
    }
    
    method perderVida(){
        vida-=50
    }

    method estaVivo() = vida > 0

    method moverse(){
        hitbox.forEach({a => a.moverse(direccion)})
        contadorMovimiento+=1
        if(contadorMovimiento==rangoMovimiento){
            contadorMovimiento = 0
            self.direccion(!direccion)
        }
    }
}

class BossHitBox {
    var property position
    method esBossHitbox() = true
    method esBeneficio() = false
    
    method image() = "1.png"
    method moverse(direccion){// false izq true der
        if(direccion){  
            self.position(self.position().right(1))
        }
        else{
            self.position(self.position().left(1))
        }
    }   
}