import parcelas.*
import semillas.*

object inta {
	var property parcelas = []
	
	method promedioDePlantas() {
		return parcelas.sum({ parcela => parcela.plantas().size()}) / parcelas.size()
	}
	method masAutoSustentable() {
		return parcelas.filter({ p => p.plantas().size() > 4 }).max({ parcela => parcela.plantasAsociadas()})
	}
}
