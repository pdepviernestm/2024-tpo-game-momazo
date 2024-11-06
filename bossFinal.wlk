import elementos.*
object cerebroBoss {
    var property vida = 120
    const hitbox = []
    var property direccion = true // false izq true der
    var property contadorMovimiento = 0

    method serHiteado() {}

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
    var property valorImagen

    method image() {
        if (valorImagen == 1){
            return "boss1.png"
        } else {
            return "invisible.png"
        }
    }

    method cambiarImagen() {
        if(cerebroBoss.vida() > 50){
            return self.image()
        }
        else{
            if (valorImagen == 1){
                return "boss2.png"
            } 
            else {
                return "invisible.png"
            }
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
