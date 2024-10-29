import elementos.*
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