import parcelas.*

class PlantaGenerica {
	const property anioObtencion 
	var property altura
	
	method horasDeSolTolerables()
	method esFuerte(){
		return self.horasDeSolTolerables() > 10
	}
	method daSemillas() {
		return self.esFuerte()
	}
	method espacioQueOcupa()
	method esParcelaIdeal(unaParcela)
	method seAsociaBien(unaParcela) {
		return unaParcela.seAsocia(self)
	} 
}

class Menta inherits PlantaGenerica {
	override method horasDeSolTolerables() = 6
	override method daSemillas() {
		return super() or altura > 0.4 
	}
	override method espacioQueOcupa() { return altura * 3}
	override method esParcelaIdeal(unaParcela) {
		return unaParcela.superficie() > 6
	}
}

class Soja inherits PlantaGenerica {
	override method horasDeSolTolerables() {
		return if (altura < 0.6) {
			6
		} else if (altura.between(0.5, 1) ){
			7
		} else if (altura > 1) {
			9
		}
	}
	method esDeObtencionReciente() {
		return anioObtencion > 2007
	}
	override method daSemillas() {
		return super() or (self.esDeObtencionReciente() and altura > 1)
	}
	override method espacioQueOcupa() { return altura / 2 } 
	override method esParcelaIdeal(unaParcela) {
		return self.horasDeSolTolerables() == unaParcela.horasDiariasDeSol()
	}
}

class Quinoa inherits PlantaGenerica {
	const property horasDeSolTolerables
	override method espacioQueOcupa() { return 0.5 }
	method cumpleConCantidadDeAnios() {
		return anioObtencion < 2005
	}
	override method daSemillas() {
		return super() or self.cumpleConCantidadDeAnios()
	}
	override method esParcelaIdeal(unaParcela) {
		return unaParcela.plantas().all({planta => planta.altura() < 1.5})
	}
	
}

class SojaTransgenica inherits Soja {
	override method daSemillas() = false
	override method esParcelaIdeal(unaParcela) {
		return unaParcela.cantidadMaxDePlantas() == 1
	}
}

class Hierbabuena inherits Menta {
	override method espacioQueOcupa() {
		return super()*2 
	}
}