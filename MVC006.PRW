#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MVC006

Cadastro Amarracao Atendente X Tipo de Chamado

@author Rogério O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
User Function MVC006()

Local oBrw := FwMBrowse():New()

oBrw:SetDescription("Atendente X Tipo de Chamado") 
oBrw:SetAlias("ZZE")

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
Local oStruZZE  := FwFormStruct(1,"ZZE")

// Cria o objeto do Modelo de Dados
Local oModel    := MPFormModel():New("MVC006_M")

//gatilho nome do tecnico
aAux := FwStruTrigger("ZZE_CODTEC","ZZE_NOMTEC",'POSICIONE("ZZA",1,XFILIAL("ZZA") + FwFldGet("ZZE_CODTEC"),"ZZA_NOME")')
oStruZZE:AddTrigger(aAux[1],aAux[2],aAux[3],aAux[4])

//gatilho nome tipo de chamado
aAux := FwStruTrigger("ZZE_TIPOCH","ZZE_DESTIP",'POSICIONE("ZZC",1,XFILIAL("ZZC") + FwFldGet("ZZE_TIPOCH"),"ZZC_DESC")')
oStruZZE:AddTrigger(aAux[1],aAux[2],aAux[3],aAux[4])

// Adiciona ao modelo um componente de formulário
oModel:AddFields("ZZEMASTER",/*cOwner*/,oStruZZE)

// Adiciona a descrição do Modelo de Dados 
oModel:SetDescription("Atendente X Tipo de Chamado")

// Adiciona a descrição do Componente do Modelo de Dados
oModel:GetModel("ZZEMASTER" ):SetDescription("Atendente X Tipo de Chamado")

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
Local oModel   := FwLoadModel("MVC006")

// Cria a estrutura a ser usada na View 
Local oStruZZE := FwFormStruct(2,"ZZE")

// Interface de visualização construída 
Local oView 

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados será utilizado na View
oView:SetModel(oModel)

// Adiciona no nosso View um controle do tipo formulário  
// (antiga Enchoice
oView:AddField("VIEW_ZZE",oStruZZE,"ZZEMASTER")

// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox("TELA",100)

// Relaciona o identificador (ID) da View com o "box" para exibição 
oView:SetOwnerView( 'VIEW_ZZE', 'TELA' )

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

Return FWMVCMenu( "MVC006" )