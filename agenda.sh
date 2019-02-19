#!/bin/bash

#Adicionar_Contato
add(){
	echo ""
	echo "     Nome Completo: "; read nome
	echo "     Telefone: "; read tel
	echo "     Celular: "; read cel
	echo "     Aniversario"
	echo "     Dia: "; read dia
	echo "     Mes: "; read mes
	echo ""
	echo $nome"-"$tel"-"$cel"-"$dia"/"$mes >> agenda.txt
	echo ""
	echo "Contato Criando Com Sucesso"
	sleep 1
}

#Atualizar_Contato
atualizar(){
	echo "-----Atualizar_contato-----"
	echo ""
		cat agenda.txt | cut -d"-" -f1
	echo "     Digite o Contato que deseja alterar: "
	read nomea
	echo ""
	echo "     Tem certeza que deseja alterar `grep -i $nomea agenda.txt`?(s/n)"
	read confirm
	if [ $confirm = "s" -o $confirm = "S" ]; then
		echo ""
		echo "     Oque gostaria de fazer: "
		echo " 1 - Mudar nome"
		echo " 2 - Mudar Telefone"
		echo " 3 - Mudar Celular"
		echo " 4 - Mudar Data de Aniversario"
		read opc

		case $opc in
			1)echo "     Novo Nome: "; read nome
			na=`grep -i $nomea agenda.txt | cut -d"-" -f1`
			sed -i "/^$nomea/s/$na/$nome/" agenda.txt
			;;
			2)echo "     Novo Telefone: "; read tel
			nt=`grep -i $nomea agenda.txt | cut -d"-" -f2`
			sed -i "/^$nomea/s/$nt/$tel/" agenda.txt
			;;
			3)echo "     Novo Celular: "; read cel
			nc=`grep -i $nomea agenda.txt | cut -d"-" -f3`
			sed -i "/^$nomea/s/$nc/$cel/" agenda.txt
			;;
			4)echo "     Mes: "; read mes
			ma=`grep -i $nomea agenda.txt | cut -d"/" -f2`
			sed -i "/^$nomea/s/$ma/$mes/" agenda.txt
			;;
		esac
	echo "Operacao Concluida"
	sleep 1

	fi
			

}

#Excluir_Contato
excluir(){
	echo "-----Excluir_contato-----"
	echo ""
		cat agenda.txt
	read -p "     Digite o nome do contato a ser deletado: " nomed
	echo "     Tem certeza que deseja excluir `cat agenda.txt| grep -i $nomed`? (s/n)"
	read confirma
	if [ $confirma = "s" -o $confirma = "S" ]; then
	grep -i $nomed agenda.txt >> rec.txt
	sed -i -e "/$nomed/d" agenda.txt
	echo "Operacao Concluida"
	fi

}
#Recuperar_Contato
recuperar(){
	echo "     Qual contato deseja recuperar?"
	echo ""
	echo "`cat rec.txt`"
	echo ""
	read -p "->" nomer
	echo "     Tem certeza que deseja recuperar `cat rec.txt| grep -i $nomer`? (s/n)"
	read confirma
	if [ $confirma = "s" -o $confirma = "S" ]; then
	grep -i $nomer rec.txt >> agenda.txt
	sed -i -e "/$nomer/d" rec.txt
	echo "Operacao Concluida"
	fi

}

#Ordernar_Contato
ordenar(){
sort -o agenda.txt agenda.txt
echo "Operacao Completa"
sleep 1
}
#Details
details(){
	echo ""
	echo "----------Detalhes----------"
	echo ""
	echo "1 - Quantidade de Contatos na Agenda"
	echo "2 - Aniversario(s) no Mes"
	read opc

case $opc in
	1)QT;;
	2)AN;;
esac
}
#QT
QT(){
echo "O total de Contatos na agenda eh:"
wc -l agenda.txt
sleep 2
}
#DataAniversario
AN(){
data_atual=$(date "+%m")
data_gerada=`grep -m1 "/"$data_atual agenda.txt | cut -d"/" -f2`
if [ "$data_gerada" -eq "$data_atual" ]; then

	echo "----------Aniversarios----------"
	echo ""
	echo "`grep "/"$data_atual agenda.txt | cut -d"-" -f1,4`"
	echo ""
else
	echo "     Sem aniversariantes no mes atual"
fi
sleep 1
}
#Menu_Principal
while true
do
	echo ""
	echo "----------Agenda----------"
	echo ""
	echo "1 - Adicionar Contato"
	echo "2 - Alterar Contato"
	echo "3 - Excluir Contato"
	echo "4 - Recuperar Contatos"
	echo "5 - Ordenar Contatos"
	echo "6 - Mais Detalhes"
	echo "7 - SAIR"
	read opc

case $opc in
	1)add;;
	2)atualizar;;
	3)excluir;;
	4)recuperar;;
	5)ordenar;;
	6)details;;
	7)exit 0
esac
done

