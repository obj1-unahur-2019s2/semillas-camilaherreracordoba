import semillas.*

class Parcela {
	const property ancho
	const property largo
	const property horasDiariasDeSol
	var property plantas = []
	
	method superficie() {return ancho * largo }
	
	method cantidadMaxDePlantas() {
		return if (ancho > largo) {
			self.superficie() / 5
		} else {
			self.superficie() / 3 + largo
		}
	}
	method tieneComplicaciones() {
		return plantas.any({ planta => planta.horasDeSolTolerables() < horasDiariasDeSol })
	}
	method esMuchoSol(unaPlanta) {
		return unaPlanta.horasDeSolTolerables() + 2 < horasDiariasDeSol
	}
	method puedePlantar(unaPlanta) {
		return not self.esMuchoSol(unaPlanta) and self.cantidadMaxDePlantas() != plantas.size()
	}
	method plantar(unaPlanta) {
		if (not self.puedePlantar(unaPlanta)) {
			self.error("no se puede plantar")
		} else {
			plantas.add(unaPlanta)
		}
	}
	method seAsocia(planta) 
	
	method plantasAsociadas() {
		return plantas.filter({ planta => planta.seAsociaBien(self)})
	}	 
}

class Ecologica inherits Parcela {
	override method seAsocia(planta) {
		return not self.tieneComplicaciones() and planta.esParcelaIdeal(self)
	}
}

class Industrial inherits Parcela {
	override method seAsocia(planta) {
		return not self.cantidadMaxDePlantas() and planta.esFuerte()
	}
}

