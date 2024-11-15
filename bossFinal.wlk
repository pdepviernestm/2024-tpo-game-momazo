import elementos.*
import menu.*
import contador.winOrLose

object cerebroBoss {
    var property vida = 320
    const hitbox = []
    var property direccion = true // false izq true der
    var property contadorMovimiento = 0
    var contadorBossHitbox = 0
    
    method perderVida(){
        vida-=50
        hitbox.forEach({a => a.cambiarImagen(vida)})
        if(vida<=0){
            winOrLose.gane()
        }
    }

    method estaVivo() = vida > 0

    method iniciarMovimiento(){
        game.onTick(200, "Movimiento Boss", { self.moverse() })
    }

    method moverse(){
        hitbox.forEach({a => a.moverse(direccion)})
        contadorMovimiento+=1
        if(contadorMovimiento==rangoMovimiento){
            contadorMovimiento = 0
            self.direccion(!direccion)
        }
    }  

    // crear hitbox
    method crearHitbox() { // me lo envia nave cuanto tiene las llaves suficientes
        soundtrack.cambiarMusica("bossSoundtrack.mp3")
        largoJefe.times({ _ => 
            const bossHitbox = new BossHitBox(position = game.at(contadorBossHitbox,alturaBoss), valorImagen = contadorBossHitbox)
            game.addVisual(bossHitbox)
            hitbox.add(bossHitbox)
            bossHitbox.inicializar()
            contadorBossHitbox += 1
        })
        self.iniciarMovimiento()
    } 
}

class BossHitBox {
    var property position
    var property valorImagen
    var property textoImagen = "invisible.png"

    method inicializar() {
        if (valorImagen == 0){
            self.textoImagen("boss1.png")
        } else {
            self.textoImagen("invisible.png")
        }
    }

    method image() = textoImagen

    method cambiarImagen(vidaActualCerebro) {
        if(vidaActualCerebro < 150 && valorImagen == 0){
            textoImagen = "boss2.png"
        }
    }
        
    method moverse(direccion){// false izq true der
        if(direccion){  
            self.position(self.position().right(1))
        }
        else{
            self.position(self.position().left(1))
        }
    }
    method colisionBala(bala){ 
        bala.delete()
        cerebroBoss.perderVida() 
    }   
}