const alturaBotonMasAlto = 15 // El de PLAY
                              // El de RULES
const alturaBotonMasBajo = 15 // El de CONTROLS
const distanciaEntreBotones = 4

object menu {
    var property image ="menuInicio.png"
    var property position = game.origin() 
}
 
object puntero {
    var property position = game.at(0, 0)

    method arriba(){
        if (self.position().y()<alturaBotonMasAlto){
            self.position(position.up(distanciaEntreBotones))
        }
    }

    method abajo(){
        if (self.position().y()>alturaBotonMasBajo){
            self.position(position.down(distanciaEntreBotones))
        }
    }

    method confirmar(){
        if(self.position()==play.position()){
            play.iniciarJuego()
        }
        else if(self.position()==rules.position()){
            rules.mostrar()
        }
        else{
            controls.mostrar()
        }
    }
}

class BotonMostrar {
    var property position 
    method mostrar (){
        //Muestra la imagen en grande de los controles o las reglas
    }
}

const controls = new BotonMostrar(game.at(15,10))
const rules = new BotonMostrar(game.at(15,10))

object play{
    var property position 
    method iniciarJuego(){
        // Da la señal para terminar la ejecucio n del menu
    }
}