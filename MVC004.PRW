#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MVC004

Cadastro MVC de Tabela de Tipos de Chamados

@author Rog�rio O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
User Function MVC004()

Local oBrw := FwMBrowse():New()

oBrw:SetDescription("Cadastro de Chamados") 
oBrw:SetAlias("ZZD")
oBrw:AddLegend( "ZZD_STATUS == '1' ", "GREEN" , "Aberto" )
oBrw:AddLegend( "ZZD_STATUS == '2' ", "BLUE" , "Em Atendimento" ) 
oBrw:AddLegend( "ZZD_STATUS == '3' ", "YELLOW" , "Aguardando") 
oBrw:AddLegend( "ZZD_STATUS == '4' ", "BLACK" , "Encerrado" ) 
oBrw:AddLegend( "ZZD_STATUS == '5' ", "RED" , "Em Atraso" ) 

oBrw:Activate()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef

Funcao generica MVC do model

@return oModel - Objeto do Modelo MVC

@author Rog�rio O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ModelDef()

// Cria a estrutura a ser usada no Modelo de Dados
Local oStruZZD  := FwFormStruct(1,"ZZD")

// Cria o objeto do Modelo de Dados
Local oModel    := MPFormModel():New("MVC004_M")

//gatilho nome do tecnico
aAux := FwStruTrigger("ZZD_TECNIC","ZZD_NOMTEC",'POSICIONE("ZZA",1,XFILIAL("ZZA") + FwFldGet("ZZD_TECNIC"),"ZZA_NOME")')
oStruZZD:AddTrigger(aAux[1],aAux[2],aAux[3],aAux[4])

//gatilho do SLA
aAux := FwStruTrigger("ZZD_PRIORI","ZZD_DESPRI",'POSICIONE("ZZB",1,XFILIAL("ZZB") + FwFldGet("ZZD_PRIORI"),"ZZB_DESC")')
oStruZZD:AddTrigger(aAux[1],aAux[2],aAux[3],aAux[4])

//gatilho nome tipo de chamado
aAux := FwStruTrigger("ZZD_TIPO","ZZD_DESTIP",'POSICIONE("ZZC",1,XFILIAL("ZZC") + FwFldGet("ZZD_TIPO"),"ZZC_DESC")')
oStruZZD:AddTrigger(aAux[1],aAux[2],aAux[3],aAux[4])

// Adiciona ao modelo um componente de formul�rio
oModel:AddFields("ZZDMASTER",/*cOwner*/,oStruZZD)

// Adiciona a descri��o do Modelo de Dados 
oModel:SetDescription("Cadastro de Chamados")

// Adiciona a descri��o do Componente do Modelo de Dados
oModel:GetModel("ZZDMASTER" ):SetDescription("Cadastro de Chamados")

// Retorna o Modelo de dados 
Return(oModel)

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef

Funcao generica MVC do View

@return oView - Objeto da View MVC

@author Rog�rio O Candisani 
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ViewDef()

// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
Local oModel   := FwLoadModel("MVC004")

// Cria a estrutura a ser usada na View 
Local oStruZZD := FwFormStruct(2,"ZZD")

// Interface de visualiza��o constru�da 
Local oView 

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados ser� utilizado na View
oView:SetModel(oModel)

// Adiciona no nosso View um controle do tipo formul�rio  
// (antiga Enchoice
oView:AddField("VIEW_ZZD",oStruZZD,"ZZDMASTER")

// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox("TELA",100)

// Relaciona o identificador (ID) da View com o "box" para exibi��o 
oView:SetOwnerView( 'VIEW_ZZD', 'TELA' )

// Retorna o objeto de View criado
Return(oView)

//----------------------------------------------------------
/*/{Protheus.doc} MenuDef()
MenuDef   

@author Rog�rio O Candisani 
@since 
@version 
/*/
//----------------------------------------------------------
Static Function MenuDef()

Return FWMVCMenu( "MVC004" )

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} GtNomTec

Gatilho do Nome do T�cnico

@author 	Rog�rio O Candisani  
@since 		
@version 	

/*/
//--------------------------------------------------------------------------------------------------------------------
User Function GtNomTec()

Local cNomTec := ""

//�ndice da tabela ZZA
cNomTec := ALLTRIM(POSICIONE("ZZA",1,XFILIAL("ZZA") + FwFldGet("ZZD_TECNIC"),"ZZA_NOME"))

Return(cNomTec)