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

pred show[ ] { }

run show for 61
