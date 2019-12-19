#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MVC007

Cadastro Amarracao Atendente X Nivel de atendimento (SLA)

@author Rogério O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
User Function MVC007()

Local oBrw := FwMBrowse():New()

oBrw:SetDescription("Atendente X Nivel de atendimento (SLA)") 
oBrw:SetAlias("ZZF")

oBrw:Activate()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef

Funcao generica MVC do model

@return oModel - Objeto do Modelo MVC

@author Rogério O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ModelDef()

// Cria a estrutura a ser usada no Modelo de Dados
Local oStruZZF  := FwFormStruct(1,"ZZF")

// Cria o objeto do Modelo de Dados
Local oModel    := MPFormModel():New("MVC007_M")

//gatilho nome do tecnico
aAux := FwStruTrigger("ZZF_CODTEC","ZZF_NOMTEC",'POSICIONE("ZZA",1,XFILIAL("ZZA") + FwFldGet("ZZF_CODTEC"),"ZZA_NOME")')
oStruZZF:AddTrigger(aAux[1],aAux[2],aAux[3],aAux[4])

//gatilho do SLA
aAux := FwStruTrigger("ZZF_TIPSLA","ZZF_DESPRI",'POSICIONE("ZZB",1,XFILIAL("ZZB") + FwFldGet("ZZF_TIPSLA"),"ZZB_DESC")')
oStruZZF:AddTrigger(aAux[1],aAux[2],aAux[3],aAux[4])

// Adiciona ao modelo um componente de formulário
oModel:AddFields("ZZFMASTER",/*cOwner*/,oStruZZF)

// Adiciona a descrição do Modelo de Dados 
oModel:SetDescription("Atendente X Nivel de atendimento (SLA)")

// Adiciona a descrição do Componente do Modelo de Dados
oModel:GetModel("ZZFMASTER" ):SetDescription("Atendente X Nivel de atendimento (SLA)")

//Seta a chave primária 
oModel:SetPrimaryKey( {} ) 
// Retorna o Modelo de dados 
Return(oModel)

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef

Funcao generica MVC do View

@return oView - Objeto da View MVC

@author Rogério O Candisani 
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ViewDef()

// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
Local oModel   := FwLoadModel("MVC007")

// Cria a estrutura a ser usada na View 
Local oStruZZF := FwFormStruct(2,"ZZF")

// Interface de visualização construída 
Local oView 

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados será utilizado na View
oView:SetModel(oModel)

// Adiciona no nosso View um controle do tipo formulário  
// (antiga Enchoice
oView:AddField("VIEW_ZZF",oStruZZF,"ZZFMASTER")

// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox("TELA",100)

// Relaciona o identificador (ID) da View com o "box" para exibição 
oView:SetOwnerView( 'VIEW_ZZF', 'TELA' )

// Retorna o objeto de View criado
Return(oView)

//----------------------------------------------------------
/*/{Protheus.doc} MenuDef()
MenuDef   

@author Rogério O Candisani 
@since 
@version 
/*/
//----------------------------------------------------------
Static Function MenuDef()

Return FWMVCMenu( "MVC007" )