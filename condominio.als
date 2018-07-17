module condominio

-- Assinaturas

sig Casa {
	profissionais: set Profissional
}

abstract sig Profissional { }

sig Auxiliar, Decorador, Eletricista, Fiscal, Pedreiro, Pintor extends Profissional { }

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

fact semAuxiliaresDemaisNumaCasa{
	all c: Casa | (#getAuxiliares[c] <= 2)
}

fact semPinturaDuranteAlvenaria {
	all ptr: Pintor | all pdr: Pedreiro | (ptr.~profissionais != pdr.~profissionais)
}

fact semPinturaDuranteObraEletrica {
	all p: Pintor | all e: Eletricista | (p.~profissionais != e.~profissionais)
}

fact semDecoracaoDuranteAlvenaria {
	all d: Decorador | all p: Pedreiro | (d.~profissionais != p.~profissionais)
}

fact semDecoracaoDuranteObraEletrica {
	all d: Decorador | all e: Eletricista | (d.~profissionais != e.~profissionais)
}

fact semDecoracaoDurantePintura {
	all d: Decorador | all p: Pintor | (d.~profissionais != p.~profissionais)
}

-- Predicados

pred show[ ] { }

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

fun getFiscais [c: Casa] : set Fiscal {
    Fiscal & c.profissionais
}


fun getPedreiros [c: Casa] : set Pedreiro {
    Pedreiro & c.profissionais
}

fun getPintores [c: Casa] : set Pintor {
    Pintor & c.profissionais
}

-- Assertions

-- Checks

-- Run

run show for 61
