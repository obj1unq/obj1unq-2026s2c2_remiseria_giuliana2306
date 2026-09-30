object combiAdaptable {
    var interior = null
    var motor = null

    method capacidad() {
        return interior.capacidad()
    }
    method velocidadMax() {
        return motor.velocidadMax()
    }
    method esRuidoso() {
        return motor.esRuidoso()
    }
    method autonomia() {
        return motor.autonomia()
    }
    method color() {
        return "celeste"
    }
    method asignarInterior(_interior) {
        interior = _interior
    }
    method asignarMotor(_motor) {
        motor = _motor
    }
    method puedeTransportarSilla() {
      return interior.puedeTransportarSilla()
    }
}
class Torino {
     var property velocidadMax = 1
     var property color = "azul" 
     var property autonomia = 0 

     method capacidad() {
        return 4 
     }
     method esRuidoso() {
        return true
     }
     method puedeTransportarSilla() {
        return false
     }
}

class Economico {
    var adaptaciones = #{}
    const autonomia = 200 

    method añadirAdaptacion(_adaptacion) {
        adaptaciones.add(_adaptacion)
    }
    method capacidad() {
        return 5 - self.sumaDeCapacidades()
    }
    method sumaDeCapacidades() {
      return adaptaciones.sum({adaptacion => adaptacion.capacidad()})
    }
    method velocidadMax() {
        if (not self.velocidadTotal().isEmpty()) {
            return self.velocidadTotal().min()
        } else {
            return 120
        }
    }
    method color() {
        return "beige"
    }
    method esRuidoso() {
        if (adaptaciones == #{}) {
            return true
        } else {
            return self.tieneAdaptaciones()
        }
    }

    method tieneAdaptaciones () {
        return adaptaciones.contains(cañoDeEscapeSilencioso) && 
        adaptaciones.contains(tanqueExtraDeGas)
    }
    method puedeTransportarSilla() {
        return adaptaciones.contains(transportadorParaSilla)
    }
    method autonomia () {
        if (adaptaciones == #{}) {
            return autonomia
        } else {
            return autonomia + self.autonomiaDeAdaptaciones()
        }
    }
    method autonomiaDeAdaptaciones() {
        return adaptaciones.sum({adaptacion => adaptacion.autonomia()})
    }
    method velocidadTotal() {
        return adaptaciones.map({adaptacion => adaptacion.velocidadMax()})
    }
}
object tanqueExtraDeGas {

    method capacidad() {
        return 1
    }
    method velocidadMax() {
        return 80
    }
    method autonomia() {
        return 200
    }
}

object cañoDeEscapeSilencioso {

    method capacidad() {
        return 0
    }
    method velocidadMax() {
        return 115
    }
    method autonomia() {
        return -10
    }
}

object transportadorParaSilla {

    method capacidad() {
        return 1
    }
    method velocidadMax() {
        return 90
    }
    method autonomia() {
        return -20
    }
}

object deportivo {

    method autonomia() {
        return 400
    }
    method velocidadMax() {
        return 230
    }
    method esRuidoso() {
        return true
    }
}

object urbano {

    method autonomia() {
        return 1000
    }
    method velocidadMax() {
        return 130
    }
    method esRuidoso() {
        return false
    }
}

object interiorEspacioso {

    method capacidad() {
        return 7
    }
     method puedeTransportarSilla() {
        return false
     }
}

object interiorAccesible {

    method capacidad() {
        return 5
    }
     method puedeTransportarSilla() {
        return true
     }
}