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
        return adaptaciones.contains(cañoDeEscapeSilencioso) || 
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

class Reserva {
    var property cantDePersonas = 0
    var property distanciaARecorrer = 0
    var property tiempoMaximoDeViaje = 0
    var property tieneSillaDeRuedas = false
    var property necesitaSilencio = false 
    var coloresContraindicados = #{}

    method puedeSerCumplidaPor(_vehiculo) {
        return self.tieneCapacidadIgualOSuperior(_vehiculo)  && 
               self.tieneAutonomiaIgualOSuperior(_vehiculo)  &&
               self.velocidadSuperaALaDelPromedio(_vehiculo) &&
               self.cumpleNecesidadesDePasajeros(_vehiculo)
    }
    method añadirColorContraindicado(_color) {
        coloresContraindicados.add(_color)
    }
    method tieneCapacidadIgualOSuperior(_vehiculo) {
       return _vehiculo.capacidad() >= cantDePersonas
    }    
    method tieneAutonomiaIgualOSuperior(_vehiculo) {
        return _vehiculo.autonomia() >= distanciaARecorrer
    }
    method velocidadSuperaALaDelPromedio(_vehiculo) {
        return _vehiculo.velocidadMax() >= (self.velocidadPromedio() + 10)
    }
    method velocidadPromedio() {
        return distanciaARecorrer / tiempoMaximoDeViaje
    }
    method cumpleNecesidadesDePasajeros(_vehiculo) {
        return ( not self.tieneColores(_vehiculo, coloresContraindicados)) && 
                 self.necesitaSillaDeRuedas(_vehiculo)               &&
                 self. necesitaQueNoSeaRuidoso(_vehiculo)
    }
    method necesitaSillaDeRuedas(_vehiculo) {
        if (tieneSillaDeRuedas) {
            return _vehiculo.puedeTransportarSilla()
        } else {
            return true
        }
    }
    method necesitaQueNoSeaRuidoso(_vehiculo) {
        if (necesitaSilencio) {
            return not _vehiculo.esRuidoso()
    } else {
        return true
    }
    }
    method tieneColores(_vehiculo, _coloresContraindicados) {
       return _coloresContraindicados.contains(_vehiculo.color())   
    }
}

class Sucursal {
    var flotaDeVehiculos = #{}
    var historialDeViajesRealizados = []

    method agregarVehiculo(_vehiculo) {
        flotaDeVehiculos.add(_vehiculo)
    }
    method quitarVehiculo(_vehiculo) {
        flotaDeVehiculos.remove(_vehiculo)
    }
    method vehiculosQueCumplen(_reserva) {
        return flotaDeVehiculos.filter({vehiculo => _reserva.puedeSerCumplidaPor(vehiculo)})
    }
    method registrarViaje(_reserva, _vehiculo) {
        const viaje1 = new Viaje()
        viaje1.reserva(_reserva)
        viaje1.vehiculo(_vehiculo)
        self.validarRegistrarViaje(_reserva, _vehiculo)
        historialDeViajesRealizados.add(viaje1)
    }
    method validarRegistrarViaje(_reserva, _vehiculo) {
        if (not self.vehiculosQueCumplen(_reserva).contains(_vehiculo)) {
            self.error("No se puede registrar viaje")
        }
    }
    method reservasQueResolvio(_vehiculo) {
        return self.viajesDelVehiculo(_vehiculo).map({viaje => viaje.reserva()})
    }
    method viajesDelVehiculo(_vehiculo) {
        return historialDeViajesRealizados.filter({viaje => viaje.vehiculo() == _vehiculo})
    }
    method distanciaTotalRecorridaEnLosViajes(_vehiculo) {
        return self.reservasQueResolvio(_vehiculo).sum({reserva => reserva.distanciaARecorrer()})
    }
    method historialDeViajesRealizados() {
        return historialDeViajesRealizados
    }
}

class Viaje {
    var property reserva = null
    var property vehiculo = null  
}