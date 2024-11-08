import contador.*
import elementos.*
object cerebroBoss {
    var property vida = 200
    const hitbox = []
    var property direccion = true // false izq true der
    var property contadorMovimiento = 0

    method serHiteado() {}

    method agregarHitbox (elementoHitbox) {
        hitbox.add(elementoHitbox)
    }
    
    method perderVida(){
        vida-=50
        hitbox.forEach({a => a.cambiarImagen()})
        if(vida<=0){
            winOrLose.gane()
        }
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
    var property valorImagen
    var imagen = "invisible.png"

    method inicializar() {
        if (valorImagen == 1){
            imagen = "boss1.png"
        }
    }
        
    method image() = imagen

    method cambiarImagen() {
        if(cerebroBoss.vida() < 100 && valorImagen == 1){
                imagen = "boss2.png"
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
    method colisionBala(bala){ cerebroBoss.perderVida() }   
}
