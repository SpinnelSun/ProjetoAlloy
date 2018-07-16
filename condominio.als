module condominio

sig Casa {
	profissionais: Profissional
}

abstract sig  Profissional { }

sig Auxiliar extends Profissional { }
sig Decorador extends Profissional { }
sig Eletricista extends Profissional { }
sig Fiscal extends Profissional { }
sig Pedreiro extends Profissional { }
sig Pintor extends Profissional { }

pred show[ ] { }

run show for 14 Casa, 10 Auxiliar, 3 Decorador, 7 Eletricista, 13 Fiscal, 9 Pedreiro, 5 Pintor
