module condominio

sig Casa {
	profissionais: set Profissional
}

abstract sig Profissional { }

sig Auxiliar, Decorador, Eletricista, Fiscal, Pedreiro, Pintor extends Profissional { }

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

pred show[ ] { }

run show for 61
