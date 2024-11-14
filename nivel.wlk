import nave.*
import bossFinal.*
import elementos.*
import vidas.*
import contador.*
import menu.*

object nivel {
    method iniciarPartida() {
        game.removeVisual(iniciar)
        game.removeVisual(configuracion)
        game.removeVisual(controles)
        game.removeVisual(puntero)
        game.removeVisual(comoJugar)
        game.removeVisual(menuInicial)
        // Visual
        game.addVisual(nave)
        game.addVisual(cohete)
        game.addVisual(medikit)
        game.addVisual(llave)

        medikit.inicializarPosicion() // La inicializo porque sino aparece y hay un tiempo en el que no cae
        llave.inicializarPosicion() // Hago que inicialice la posición de la llave para que no se vea hasta que empiece a caer
        
        puntaje.inicializar() //inicializo el puntaje
        vidasNave.agregarVidas() // agrego las vidas
            
        // Movimiento nave
        keyboard.left().onPressDo({
            if(nave.position().x() >= 1) nave.position(nave.position().left(1))
        })
        
        keyboard.right().onPressDo({
            if(nave.position().x() <= anchoDelJuego - 2) nave.position(nave.position().right(1))
        })

        // Disparar
        keyboard.space().onPressDo({ nave.dispararBala() })

        game.onTick(400, "Cooldown Disparo", {nave.cooldownDisparo()})

        var contador = 0
        maxMeteoritos.times({_ => 
            contador +=1
            game.schedule(100*contador, {
                const meteorito = new Meteorito()
                game.addVisual(meteorito)
                meteorito.inicializar()
            })
        })
        
        // Caida cohete
        game.onTick(50, "Caida cohete", {
            if(cohete.position().y() < -2)   //Lo mueve denuevo a una posicion random, con == no funciona
            {
                cohete.posicion(1.randomUpTo(anchoDelJuego-1),15.randomUpTo(altoDelJuego-3))
            }
            else
            {
                cohete.position(cohete.position().down(1))
            }
        })
        

        // Medikit
        game.onTick(5000, "Dropear Medikit",{ medikit.spawnear() })

        // Llave
        game.onTick(7000, "Dropear Llave",{ llave.spawnear() })

        // Impactos
        game.onCollideDo(nave, {elemento => elemento.colisionNave(nave) }) 

        // Contador
        game.onTick(500,"Sumar puntaje", { puntaje.sumarPuntos() })

    
    }
}