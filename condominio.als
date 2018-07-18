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

fun getEquipeInterna [c: Casa] : set Eletricista {
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

assert semLimpezaDuranteAlvenaria {
	all c: Casa | (#getPedreiros[c] > 0) => (#getAuxiliares[c] = 0)
}

assert semLimpezaDuranteObraEletrica {
	all c: Casa | (#getEletricistas[c] > 0) => (#getAuxiliares[c] = 0)
}

assert semProfissionaisOnipresentes {
	all c1: Casa, c2:Casa, p: Profissional | ((c1 != c2 ) && (p in c1.profissionais)) => (p !in c2.profissionais)
}

-- Checks

check semLimpezaDuranteAlvenaria
check semLimpezaDuranteObraEletrica
check semProfissionaisOnipresentes

-- Run

run show for 61
