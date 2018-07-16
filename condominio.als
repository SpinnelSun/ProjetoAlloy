module condominio

sig Casa {
	profissionais: set Profissional
}

abstract sig  Profissional {

}

sig Pedreiro, Pintor, Eletricista, Decorador, AuxServicosGerais, Fiscal extends Profissional {}

fact cardinalidade {
	#Casa = 14
    #Pedreiro = 9
    #Pintor = 5
	#Eletricista = 7
	#Decorador = 3
	#AuxServicosGerais = 10
	#Fiscal = 13
}

pred show[]{}

run show for 47
