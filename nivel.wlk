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
        //game.addVisual(puntaje)
        game.addVisual(cohete)
        game.addVisual(medikit)
        game.addVisual(llave)

        medikit.inicializarPosicion() // La inicializo porque sino aparece y hay un tiempo en el que no cae
        llave.inicializarPosicion() // Hago que inicialice la posición de la llave para que no se vea hasta que empiece a caer
        
        puntaje.inicializar() //inicializo el puntaje
        vidasNave.agregarVidas() // agrego las vidas
        // Sonido
        if(musica.estado()){
            game.sound("elSoundtrack.mp3").volume(0.2)
            game.sound("elSoundtrack.mp3").play()
            game.sound("elSoundtrack.mp3").shouldLoop(true)
        }
            
        // Movimiento nave
        keyboard.left().onPressDo({
            nave.position(nave.position().left(1))
        })
        
        keyboard.right().onPressDo({
            nave.position(nave.position().right(1))
        })

        // Disparar

        keyboard.space().onPressDo({ nave.dispararBala() })

        game.onTick(600, "Cooldown Disparo", {nave.cooldownDisparo()})

        var contador = 0

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

        // Caida meteorito
        game.onTick(100,"Crear Meteorito", {
            if (contador < maxMeteoritos)
            {
                const meteorito = new Meteorito()
                game.addVisual(meteorito)
                contador += 1
                game.onTick(100, "Caida Meteorito", {
                    if (meteorito.position().y()<0)
                    {
                        meteorito.posicionSpawn()
                    }
                    else
                        meteorito.position(meteorito.position().down(1))
                })
            }
        })
            
        // Boss
        var contadorBossHitbox = 0
        game.onTick(100,"Crear Boss", {
            if(contadorBossHitbox == 0){
                game.sound("elSoundtrack.mp3").stop()
                game.sound("bossSoundtrack.mp3").volume(0.2)
                game.sound("bossSoundtrack.mp3").play()
                game.sound("bossSoundtrack.mp3").shouldLoop(true)
            }
            if(nave.llaves() >= llavesNecesarias){
                if (contadorBossHitbox < largoJefe)
                {
                    const bossHitbox = new BossHitBox(position = game.at(contadorBossHitbox,alturaBoss), valorImagen = contadorBossHitbox)
                    bossHitbox.inicializar()
                    game.addVisual(bossHitbox)
                    cerebroBoss.agregarHitbox(bossHitbox)
                    contadorBossHitbox += 1
                }
                else {
                    game.removeTickEvent("Crear Boss")
                }
            }
        })
            
        game.onTick(200, "Movimiento Boss", {
            if(nave.llaves() >= llavesNecesarias){
                cerebroBoss.moverse()
            }
        })

        // Medikit
        game.onTick(5000, "Dropear Medikit",{
            medikit.posicionSpawn()
                game.onTick(200, "Caida Medikit",{
                    medikit.position(medikit.position().down(1))
                    if (medikit.position().y() < -1)
                    {
                        game.removeTickEvent("Caida Medikit")
                    }
                })
        })

        // Llave
        game.onTick(7000, "Dropear Llave",{
            if(nave.llaves() < llavesNecesarias){
                llave.posicionSpawn()
                game.onTick(200, "Caida Llave",{
                    llave.position(llave.position().down(1))
                    if (llave.position().y() < -1)
                    {
                        game.removeTickEvent("Caida Llave")
                    }
                })
            }
        })

        // Impactos
        game.onCollideDo(nave, {elemento =>
            elemento.colisionNave(nave)
        }) 

        // Contador
        game.onTick(500,"Sumar puntaje", {
            puntaje.sumarPuntos()
        })
    }
}