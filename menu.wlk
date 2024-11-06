import elementos.*
const xInicial = anchoDelJuego/2 - 4 //Despues lo pulimos bien desde aca
const yInicial = altoDelJuego/2 + 4

class Menu {
    var property position = game.at(0, 0) //Asi arranca desde abajo a la izquierda y ocupa toda la pantalla
    const property opciones

    method image() 

    method indiceDe(elemento, indice) {
    if (indice >= opciones.size()) { // Por si llega a pasarse
        return -1
    } else if (opciones.get(indice) != elemento) { // Aca esta la recursividad
        return self.indiceDe(elemento, indice + 1)
    } else { // Aca encuentra el elemento
        return indice
    }
}

method opcionSiguiente() {
    if (puntero.aQueApunto() == opciones.last()) { //El siguiente del último es el primero
        puntero.aQueApunto(opciones.first())
    } else {
        const indiceActual = self.indiceDe(puntero.aQueApunto(), 0)
        if (indiceActual != -1) {
            puntero.aQueApunto(opciones.get(indiceActual + 1))
        }
    }
    puntero.actualizarPosicion() // Llamada para actualizar la posición del puntero
    // Por algún motivo si no le indicamos que se actualice no lo hace
}

method opcionAnterior() {
    if (puntero.aQueApunto() == opciones.first()) { //El siguiente del último es el primero
        puntero.aQueApunto(opciones.last())
    } else {
        const indiceActual = self.indiceDe(puntero.aQueApunto(), 0)
        if (indiceActual != -1) {
            puntero.aQueApunto(opciones.get(indiceActual - 1))
        }
    }
    puntero.actualizarPosicion() // Llamada para actualizar la posición del puntero
    // Por algún motivo si no le indicamos que se actualice no lo hace
}
}

object menuInicial inherits Menu(opciones = [iniciar, controles, configuracion, comoJugar]) {
    override method image() = "menuInicio.png"
}

object menuConfiguracion inherits Menu(opciones = [vfx, musica]){ // Hay que ver que opciones meter
    override method image() = "opciones.png"
}

object menuControles inherits Menu(opciones = []){
    override method image() = "controles.png" // Hay que cambiarle la foto foto porque aparece el up y el down
}

object menuComoJugar inherits Menu(opciones = []){
    override method image() = "comoJugar.png" // Conseguir una foto
}

object puntero {
    var property aQueApunto = iniciar // Inicia apuntando a "iniciar"
    var property position = game.at(aQueApunto.position().x() - 2, aQueApunto.position().y()) //Inicializo la posición
    var property menuActual = menuInicial // Arranca en menu inicial

    // Actualiza la posición del puntero según la opción a la que apunta
    method actualizarPosicion() {
        position = game.at(aQueApunto.position().x() - 2, aQueApunto.position().y())
    }

    method activar() {aQueApunto.accion()}

    method image() = "punteroMomentaneo.png" //Hay que hacer que se vea bien la imagen
}

object iniciar {
    method image() = "PLAY.png"
    var property position = game.at(xInicial, yInicial)
    var property play = false //De esta forma sabe el juego cuando iniciar

    method accion() {self.play(true)}
}

object controles{
    method image() = "CONTROLS.png"
    var property position = game.at(xInicial, yInicial - 4)

    method accion() {
        game.addVisual(menuControles)
    }
}

object configuracion{
    method image() = "OPTIONS.png"
    var property position = game.at(xInicial, yInicial - 8)

    method accion() {
        game.addVisual(menuConfiguracion)
        game.addVisual(vfx)
        game.addVisual(musica)
        game.addVisual(check1)
        game.addVisual(check2)
        game.removeVisual(puntero)
        game.addVisual(puntero) //Sino se queda detras de la imagen
        puntero.aQueApunto(vfx)
        puntero.menuActual(menuConfiguracion)
        puntero.actualizarPosicion() //Sino se queda trabado
    }
}

object comoJugar{
    method image() = "HOWTOPLAY.png"
    var property position = game.at(xInicial, yInicial - 12)

    method accion() {
        game.addVisual(menuComoJugar)
    }
}

object vfx{ // Podrían ser los dos una clase porque son bastante parecido
    var property position = game.at(xInicial, yInicial - 2) 
    var property estado = true // Por defecto esta activado todo

    method image() = "vfx.png" // Nos falta esta imagen

    method accion() {
        estado = !estado
        check1.actualizarImagen()
    }
}

object musica{
    var property position = game.at(xInicial, yInicial - 6)
    var property estado = true

    method image() = "music.png"
    method accion() {
        estado = !estado
        check2.actualizarImagen()
    }
}

class CheckBox {
    const asociado
    var imagen = "tick options.png"
    var property position = game.at(asociado.position().x() + 1, asociado.position().y())
    method image() = imagen
    method actualizarImagen() {
        if(asociado.estado()){
            imagen = "tick options.png"
        }
        else imagen = "cruz options.png"
    }
}

const check1 = new CheckBox(asociado = vfx)
const check2 = new CheckBox(asociado = musica)