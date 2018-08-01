module condominio


-- Assinaturas

sig Casa {
	profissionais: set Profissional
}

abstract sig Profissional { }

abstract sig EquipeExterna, EquipeInterna extends Profissional { }

sig Auxiliar, Fiscal extends EquipeExterna { }
sig Decorador, Eletricista, Pedreiro, Pintor extends EquipeInterna { }


-- Fatos

fact NumeroDeCasas {
	#Casa = 14
}

fact NumeroDeFuncionarios {
	#Auxiliar = 10
	#Decorador = 3
	#Eletricista = 7
	#Fiscal = 13
	#Pedreiro = 9
	#Pintor = 5
}

fact umaCasaPorVez {
	all p: Profissional | one p.~profissionais
}

fact distribuirAuxiliares {
	all c: Casa | pinturaRequereLimpeza[c]
	all c: Casa | semAuxiliaresDemaisPorCasa[c]
}

fact distribuirDecoradores {
	all c: Casa | semDecoracaoDuranteConstrucaoCivil[c]
}

fact distribuirFiscais {
	all c: Casa | equipeInternaRequereFiscalizacao[c]
	all c: Casa | semFiscalizacaoDesnecessaria[c]
}

fact distribuirPedreiros {
	all c: Casa | obraEletricaRequereAlvenaria [c]
}

fact distribuirPintores {
	all c: Casa | semPinturaDuranteAlvenaria[c]
	all c: Casa | semPinturaDuranteObraEletrica[c]
}


-- Predicados

pred equipeInternaRequereFiscalizacao [c: Casa] {
	(#getEquipeInterna[c] > 0) => (#getFiscais[c] > 0)
}

pred obraEletricaRequereAlvenaria [c: Casa] {
	(#getEletricistas[c] > 0) => (#getPedreiros[c] > 0)
}

pred pinturaRequereLimpeza [c: Casa] {
	(#getPintores[c] > 0) => (#getAuxiliares[c] > 0)
}

pred semAuxiliaresDemaisPorCasa [c: Casa] {
	#getAuxiliares[c] <= 2
}

pred semDecoracaoDuranteConstrucaoCivil [c: Casa] {
	(#getProfissionaisConstrucaoCivil[c] > 0) => (#getDecoradores[c] = 0)
}

pred semFiscalizacaoDesnecessaria [c: Casa] {
	(#getEquipeInterna[c] = 0) => (#getFiscais[c] = 0)
}

pred semPinturaDuranteAlvenaria [c: Casa] {
	(#getPedreiros[c] > 0) => (#getPintores[c] = 0)
}

pred semPinturaDuranteObraEletrica [c: Casa] {
	(#getEletricistas[c] > 0) => (#getPintores[c] = 0)
}

pred show [ ] { }


-- Funções

fun getAuxiliares [c: Casa] : set Auxiliar {
    Auxiliar & c.profissionais
}

fun getDecoradores [c: Casa] : set Decorador {
    Decorador & c.profissionais
}

fun getEletricistas [c: Casa] : set Eletricista {
    Eletricista & c.profissionais
}

fun getEquipeInterna [c: Casa] : set EquipeInterna {
    EquipeInterna & c.profissionais
}

fun getFiscais [c: Casa] : set Fiscal {
    Fiscal & c.profissionais
}

fun getPedreiros [c: Casa] : set Pedreiro {
    Pedreiro & c.profissionais
}

fun getPintores [c: Casa] : set Pintor {
    Pintor & c.profissionais
}

fun getProfissionaisConstrucaoCivil [c: Casa] : set Profissional {
	(Eletricista + Pedreiro + Pintor) & c.profissionais
}


-- Asserções

assert semProfissionaisOnipresentes {
	all c1: Casa, c2: Casa, p: Profissional | ((c1 != c2 ) && (p in c1.profissionais)) => (p !in c2.profissionais)
}

assert maximoAuxiliaresPorCasa {
	no c: Casa | (#getAuxiliares[c] > 2) 
}

assert separarPedreirosPintores {
	all pdr: Pedreiro | no ptr: Pintor | (pdr.~profissionais = ptr.~profissionais)
}

assert unirPintoresAuxiliares {
	all p: Pintor | some a: Auxiliar | (p.~profissionais = a.~profissionais)
}

assert separarEletricistasPintores {
	all e: Eletricista | no p: Pintor | (e.~profissionais = p.~profissionais)
}

assert unirEletricistasPedreiros {
	all e: Eletricista | some p: Pedreiro | (e.~profissionais = p.~profissionais)
}

assert separarDecoradoresPedreiros {
	all d: Decorador | no p: Pedreiro | (d.~profissionais = p.~profissionais)
}

assert separarDecoradoresPintores {
	all d: Decorador | no p: Pintor | (d.~profissionais = p.~profissionais)
}

assert separarDecoradoresEletricistas {
	all d: Decorador | no e: Eletricista | (d.~profissionais = e.~profissionais)
}

assert unirFiscaisEquipeInterna {
	all c: Casa, f: Fiscal | (f in c.profissionais) => (#getEquipeInterna[c] > 0)
}


-- Checagens

check semProfissionaisOnipresentes for 61
check maximoAuxiliaresPorCasa for 61
check separarPedreirosPintores for 61
check unirPintoresAuxiliares for 61
check separarEletricistasPintores for 61
check unirEletricistasPedreiros for 61
check separarDecoradoresPedreiros for 61
check separarDecoradoresPintores for 61
check separarDecoradoresEletricistas for 61
check unirFiscaisEquipeInterna for 61


-- Show

run show for 61
