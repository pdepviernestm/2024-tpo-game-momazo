import menu.*
import vidas.*
const anchoDelJuego = 30
const altoDelJuego = 20
const tamanioCelda = 50
const maxMeteoritos = 12
const largoJefe = 5
const alturaBoss = 15
const cantidadBalas = 10
const rangoMovimiento = anchoDelJuego - largoJefe
const llavesNecesarias = 3

class ObjetoQueCae {
    var property position = game.at(1.randomUpTo(anchoDelJuego -4),15.randomUpTo(altoDelJuego-4))
    method posicionSpawn() {position = game.at(1.randomUpTo(anchoDelJuego-4),15.randomUpTo(altoDelJuego-4))}
    method image() 
    method inicializarPosicion() {position = game.at(0, altoDelJuego + 1)}
    // CORREGIR agregar colisionNave y despues usarlo con super
    method afectar(nave){}
    method colisionNave(nave) {
        self.afectar(nave)
        self.position(game.at(0,-1))
    }
}

class Meteorito inherits ObjetoQueCae() {
    // GAME
    override method image() = "meteoritoFinal.png"
    override method afectar(nave){
        nave.modificarVida(-1)
        vidasNave.quitarVida()
    }
    override method colisionNave(nave){
        super(nave)
        soundtrack.efecto("impacto.mp3")
    }
    method colisionBala(bala){
        self.position(game.at(0,-1))
        bala.delete()
    }
    method inicializar(){
        game.onTick(100, "Caida Meteorito", {
            if (self.position().y()<0) {
                self.posicionSpawn()
            }
            else
                self.position(self.position().down(1))
        })
    }    
}

object medikit inherits ObjetoQueCae {
    override method image() = "vidaNave.png"
    override method afectar(nave){
        if(nave.vidasNave() <3){
            nave.modificarVida(1)
            vidasNave.sumarVida() //CORREGIR que la nave sume la vida
        } 
    }
    override method colisionNave(nave){
        super(nave)
        soundtrack.efecto("curar.mp3")
    }
    method spawnear(){
        self.posicionSpawn()
        game.onTick(200, "Caida Medikit",{
            self.position(self.position().down(1))
            if (self.position().y() < -1)
            {
                game.removeTickEvent("Caida Medikit")
            }
        })
    }
    method colisionBala(bala){}
}

object llave inherits ObjetoQueCae {
    var property puedoSpawnear = 1 
    override method image() = "llave.png"
    override method afectar(nave) {
        nave.conseguirLlave()
    }
    override method colisionNave(nave){
        super(nave)
        soundtrack.efecto("LLAVE.mp3")
    }
    method colisionBala(bala){}
    method finalizar(){
        self.puedoSpawnear(-1)
        game.removeTickEvent("Dropear Llave")
    }
    method spawnear(){
        if (puedoSpawnear == 1){
            self.posicionSpawn()
            game.onTick(200, "Caida Llave",{
                self.position(self.position().down(1))
                if (self.position().y() < -1) {
                    game.removeTickEvent("Caida Llave")
                }
            })
        }
    }
}

object cohete inherits ObjetoQueCae {
    override method image() = "cohete.png"
    method posicion(x,y){            
        position = game.at(x,y)
    }
    override method afectar(nave){
        nave.morir()
    }
    override method colisionNave(nave){
        super(nave)
    }
    method colisionBala(bala){
        self.position(game.at(0,-1))
        bala.delete()
    }
}

