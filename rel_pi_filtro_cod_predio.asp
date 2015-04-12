<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cpf.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,4,3"
MM_authFailedURL="erro.asp"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (false Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If
%>
<%
Dim Recordset1__MMColParam
Recordset1__MMColParam = "1"
If (Request.Form("cod_predio") <> "") Then 
  Recordset1__MMColParam = Request.Form("cod_predio")
End If
%>
<%
Dim Recordset1
Dim Recordset1_cmd
Dim Recordset1_numRows

Set Recordset1_cmd = Server.CreateObject ("ADODB.Command")
Recordset1_cmd.ActiveConnection = MM_cpf_STRING
Recordset1_cmd.CommandText = "SELECT * FROM cLista_pi WHERE cod_predio = ?" 
Recordset1_cmd.Prepared = true
Recordset1_cmd.Parameters.Append Recordset1_cmd.CreateParameter("param1", 200, 1, 255, Recordset1__MMColParam) ' adVarChar

Set Recordset1 = Recordset1_cmd.Execute
Recordset1_numRows = 0
%>
<%
Dim Recordset2__MMColParam
Recordset2__MMColParam = "1"
If (Request.Form("cod_predio") <> "") Then 
  Recordset2__MMColParam = Request.Form("cod_predio")
End If
%>
<%
Dim Recordset2
Dim Recordset2_cmd
Dim Recordset2_numRows

Set Recordset2_cmd = Server.CreateObject ("ADODB.Command")
Recordset2_cmd.ActiveConnection = MM_cpf_STRING
Recordset2_cmd.CommandText = "SELECT Count(tb_pi.PI) AS ContarDePI, Count(tb_predio.cod_predio) AS ContarDecod_predio FROM (tb_diretoria RIGHT JOIN (tb_responsavel RIGHT JOIN (((tb_predio RIGHT JOIN tb_pi ON tb_predio.cod_predio = tb_pi.cod_predio) LEFT JOIN tb_Construtora ON tb_pi.cod_construtora = tb_Construtora.cod_construtora) LEFT JOIN tb_situacao_pi ON tb_pi.cod_situacao = tb_situacao_pi.cod_situacao) ON tb_responsavel.cod_fiscal = tb_pi.cod_fiscal) ON tb_diretoria.id = tb_pi.cod_diretoria) LEFT JOIN tb_Municipios ON tb_predio.cod_mun = tb_Municipios.cod_mun WHERE  tb_predio.cod_predio = ? ORDER BY Count(tb_pi.PI), Count(tb_predio.cod_predio); " 
Recordset2_cmd.Prepared = true
Recordset2_cmd.Parameters.Append Recordset2_cmd.CreateParameter("param1", 200, 1, 255, Recordset2__MMColParam) ' adVarChar

Set Recordset2 = Recordset2_cmd.Execute
Recordset2_numRows = 0
%>
<%
Dim Recordset4
Dim Recordset4_cmd
Dim Recordset4_numRows

Set Recordset4_cmd = Server.CreateObject ("ADODB.Command")
Recordset4_cmd.ActiveConnection = MM_cpf_STRING
Recordset4_cmd.CommandText = "SELECT * FROM tb_situacao_pi" 
Recordset4_cmd.Prepared = true

Set Recordset4 = Recordset4_cmd.Execute
Recordset4_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
Recordset1_numRows = Recordset1_numRows + Repeat1__numRows
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<style type="text/css">
<!--
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 18px;
}
.style4 {font-family: Arial, Helvetica, sans-serif; font-size: 10px; }
.style10 {font-family: Arial, Helvetica, sans-serif; font-size: 9px; }
.style12 {font-family: Arial, Helvetica, sans-serif; font-size: 9px; color: #FFFFFF; }
.style15 {	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: small;
}
.style16 {
	color: #006699;
	font-weight: bold;
}
.style17 {
	color: #993333;
	font-weight: bold;
}
.style19 {color: #FFFFFF}
.style20 {color: #FFFFFF; font-family: Arial, Helvetica, sans-serif; }
.style21 {font-size: 12px}
.style23 {color: #FFFFFF; font-weight: bold; }
-->
</style>
<script language="JavaScript">
<!--
function FP_preloadImgs() {//v1.0
 var d=document,a=arguments; if(!d.FP_imgs) d.FP_imgs=new Array();
 for(var i=0; i<a.length; i++) { d.FP_imgs[i]=new Image; d.FP_imgs[i].src=a[i]; }
}

function FP_swapImg() {//v1.0
 var doc=document,args=arguments,elm,n; doc.$imgSwaps=new Array(); for(n=2; n<args.length;
 n+=2) { elm=FP_getObjectByID(args[n]); if(elm) { doc.$imgSwaps[doc.$imgSwaps.length]=elm;
 elm.$src=elm.src; elm.src=args[n+1]; } }
}

function FP_getObjectByID(id,o) {//v1.0
 var c,el,els,f,m,n; if(!o)o=document; if(o.getElementById) el=o.getElementById(id);
 else if(o.layers) c=o.layers; else if(o.all) el=o.all[id]; if(el) return el;
 if(o.id==id || o.name==id) return o; if(o.childNodes) c=o.childNodes; if(c)
 for(n=0; n<c.length; n++) { el=FP_getObjectByID(id,c[n]); if(el) return el; }
 f=o.forms; if(f) for(n=0; n<f.length; n++) { els=f[n].elements;
 for(m=0; m<els.length; m++){ el=FP_getObjectByID(id,els[n]); if(el) return el; } }
 return null;
}
// -->
</script>
</style>
<script language="JavaScript" type="text/javascript">
<!--
function abre_janela(width, height, nome) {
var top; var left;
top = ( (screen.height/2) - (height/2) )
left = ( (screen.width/2) - (width/2) )
window.open('',nome,'width='+width+',height='+height+',scrollbars=no,toolbar=no,location=no,status=no,menubar=no,resizable=no,left='+left+',top='+top);
}
function recebe_imagem(campo, imagem){
var foto = 'img_' + campo
document.form_incluir[campo].value = imagem;
document.form_incluir[foto].src = imagem;
}
function verifica_form(form) {
var passed = false;
var ok = false
var campo
for (i = 0; i < form.length; i++) {
  campo = form[i].name;
  if (form[i].df_verificar == "sim") {
    if (form[i].type == "text"  | form[i].type == "textarea" | form[i].type == "select-one") {
      if (form[i].value == "" | form[i].value == "http://") {
		form[campo].className='campo_alerta'
        form[campo].focus();
        alert("Preencha corretamente o campo");
        return passed;
        stop;
      }
    }
    else if (form[i].type == "radio") {
      for (x = 0; x < form[campo].length; x++) {
        ok = false;
        if (form[campo][x].checked) {
          ok = true;
          break;
        }
      }
      if (ok == false) {
        form[campo][0].focus();
		form[campo][0].select();
        alert("Informe uma das opcões");
        return passed;
        stop;
      }
    }
    var msg = ""
    if (form[campo].df_validar == "cpf") msg = checa_cpf(form[campo].value);
    if (form[campo].df_validar == "cnpj") msg = checa_cnpj(form[campo].value);
    if (form[campo].df_validar == "cpf_cnpj") {
	  msg = checa_cpf(form[campo].value);
	  if (msg != "") msg = checa_cnpj(form[campo].value);
	}
    if (form[campo].df_validar == "email") msg = checa_email(form[campo].value);
    if (form[campo].df_validar == "numerico") msg = checa_numerico(form[campo].value);
    if (msg != "") {
	  if (form[campo].df_validar == "cpf_cnpj") msg = "informe corretamente o número do CPF ou CNPJ";
	  form[campo].className='campo_alerta'
      form[campo].focus();
      form[campo].select();
      alert(msg);
      return passed;
      stop;
    }
  }
}
passed = true;
return passed;
}
function desabilita_cor(campo) {
campo.className='campos_formulario'
}
function checa_numerico(String) {
var mensagem = "Este campo aceita somente números"
var msg = "";
if (isNaN(String)) msg = mensagem;
return msg;
}
function checa_email(campo) {
var mensagem = "Informe corretamente o email"
var msg = "";
var email = campo.match(/(\w+)@(.+)\.(\w+)$/);
if (email == null){
  msg = mensagem;
  }
return msg;
}
function checa_cpf(CPF) {
var mensagem = "informe corretamente o número do CPF"
var msg = "";
if (CPF.length != 11 || CPF == "00000000000" || CPF == "11111111111" ||
  CPF == "22222222222" ||	CPF == "33333333333" || CPF == "44444444444" ||
  CPF == "55555555555" || CPF == "66666666666" || CPF == "77777777777" ||
  CPF == "88888888888" || CPF == "99999999999")
msg = mensagem;
soma = 0;
for (y=0; y < 9; y ++)
soma += parseInt(CPF.charAt(y)) * (10 - y);
resto = 11 - (soma % 11);
if (resto == 10 || resto == 11)resto = 0;
if (resto != parseInt(CPF.charAt(9)))
  msg = mensagem; soma = 0;
for (y = 0; y < 10; y ++)
  soma += parseInt(CPF.charAt(y)) * (11 - y);
resto = 11 - (soma % 11);
if (resto == 10 || resto == 11) resto = 0;
if (resto != parseInt(CPF.charAt(10)))
  msg = mensagem;
return msg;
}
function checa_cnpj(s) {
var mensagem = "informe corretamente o número do CNPJ"
var msg = "";
var y;
var c = s.substr(0,12);
var dv = s.substr(12,2);
var d1 = 0;
for (y = 0; y < 12; y++)
{
d1 += c.charAt(11-y)*(2+(y % 8));
}
if (d1 == 0) msg = mensagem;
d1 = 11 - (d1 % 11);
if (d1 > 9) d1 = 0;
if (dv.charAt(0) != d1)msg = mensagem;
d1 *= 2;
for (y = 0; y < 12; y++)
{
d1 += c.charAt(11-y)*(2+((y+1) % 8));
}
d1 = 11 - (d1 % 11);
if (d1 > 9) d1 = 0;
if (dv.charAt(1) != d1) msg = mensagem;
return msg;
}
function mascara_data(data){ 
var mydata = ''; 

mydata = mydata + data; 
if (mydata.length == 2){ 
mydata = mydata + '/'; 
} 
if (mydata.length == 5){ 
mydata = mydata + '/'; 
} 
return mydata; 
} 
function verifica_data(data) { 
if (data.value != "") {
dia = (data.value.substring(0,2));
mes = (data.value.substring(3,5)); 
ano = (data.value.substring(6,10)); 
situacao = ""; 
if ((dia < 01)||(dia < 01 || dia > 30) && (  mes == 04 || mes == 06 || mes == 09 || mes == 11 ) || dia > 31) { 
situacao = "falsa"; 
} 
if (mes < 01 || mes > 12 ) { 
situacao = "falsa"; 
}
if (mes == 2 && ( dia < 01 || dia > 29 || ( dia > 28 && (parseInt(ano / 4) != ano / 4)))) { 
situacao = "falsa"; 
} 
if (situacao == "falsa") { 
data.focus();
data.select();
alert("Data inválida!"); 
}
} 
}
//-->
</script>
</head>

<body>
<p><a href="http://www.cep-escolas.com.br/filtro_cod_predio.asp" class="style15">VOLTAR</a></p>
<p class="style1">Relação de PIs do SISTEMA CEP-ESCOLAS</p>
<table width="4244" border="0" bgcolor="#FFFFFF">
  <tr bgcolor="#999999">
    <td colspan="3" bgcolor="#CC9933" class="style16"><div align="center" class="style20">A Ç Õ E S</div></td>
    <td width="109" rowspan="2"><div align="center"><span class="style12">PI</span></div></td>
    <td width="199" rowspan="2"><div align="center"><span class="style12">cod_predio</span></div></td>
    <td width="230" rowspan="2"><span class="style12">Nome_Unidade</span></td>
    <td width="185" rowspan="2"><span class="style12">desc_diretoria</span></td>
    <td width="149" rowspan="2"><span class="style12">Municipios</span></td>
    <td width="239" rowspan="2"><span class="style12">Descrição da Intervenção FDE</span></td>
    <td width="55" rowspan="2"><span class="style12">Critério de Cálculo</span></td>
    <td width="61" rowspan="2"><span class="style12">Critério de Reajuste</span></td>
    <td width="60" rowspan="2"><span class="style12">Número do Contrato</span></td>
    <td width="60" rowspan="2"><span class="style12">Dígito do Contrato</span></td>
    <td width="50" rowspan="2"><span class="style12">Data Base</span></td>
    <td width="73" rowspan="2"><span class="style12">Data da Assinatura</span></td>
    <td width="78" rowspan="2"><span class="style12">Data da Impressão da OIS</span></td>
    <td width="50" rowspan="2"><span class="style12">Data da CI</span></td>
    <td width="58" rowspan="2"><span class="style12">Data da Abertura</span></td>
    <td width="86" rowspan="2"><span class="style12">Foi solicitado Aditamento?</span></td>
    <td width="60" rowspan="2"><span class="style12">Prazo do Contrato</span></td>
    <td width="78" rowspan="2"><span class="style12">Prazo do Aditamento</span></td>
    <td width="81" rowspan="2"><span class="style12">Orçamento FDE</span></td>
    <td width="169" rowspan="2"><span class="style12">Redução</span></td>
    <td width="60" rowspan="2"><span class="style12">Valor do Contrato</span></td>
    <td width="78" rowspan="2"><span class="style12">Valor do Aditamento</span></td>
    <td width="147" rowspan="2"><span class="style12">Órgão</span></td>
    <td width="95" rowspan="2"><span class="style12">Gerenciadora Mede ?</span></td>
    <td width="90" rowspan="2"><span class="style12">Descrição da Intervenção Gerenciadora</span></td>
    <td width="61" rowspan="2"><span class="style12">Fator de Redução</span></td>
    <td width="75" rowspan="2"><span class="style12">Área gerenciada</span></td>
    <td width="50" rowspan="2"><span class="style12">Data do TRP</span></td>
    <td width="61" rowspan="2"><span class="style12">É Medição Final ?</span></td>
    <td width="50" rowspan="2"><span class="style12">Data do TRD</span></td>
    <td width="85" rowspan="2"><span class="style12">Informação da Placa de Obra</span></td>
    <td width="204" rowspan="2"><span class="style12">Transferência</span></td>
    <td width="57" rowspan="2"><span class="style12">novo contrato</span></td>
    <td width="196" rowspan="2"><span class="style12">Responsável</span></td>
    <td width="186" rowspan="2"><span class="style12">Construtora</span></td>
    <td width="250" rowspan="2"><span class="style12">desc_situacao</span></td>
  </tr>
  <tr bgcolor="#CC9933">
    <td colspan="3" class="style16"><div align="center"><span class="style20">Atualizar / Incluir</span></div></td>
  </tr>
  <% While ((Repeat1__numRows <> 0) AND (NOT Recordset1.EOF)) %>
    <tr bgcolor="#CCCCCC" class="style4">
      <td width="30" bgcolor="#CC9933"><div align="center"><a href="atualiza_PI_medicoes.asp?pi=<%=(Recordset1.Fields.Item("PI").Value)%>" target="_self" class="style23"><strong>PI</strong></a></div></td>
      <td width="79" bgcolor="#CC9933"><span class="style23"><a href="acompanhamento_inclui_adm.asp?PI=<%=(Recordset1.Fields.Item("PI").Value)%>" class="style23">ACOMPANHAMENTO</a></span></td>
      <td bgcolor="#CC9933"><div align="center"><a href="med_constr_inclui.asp?PI=<%=(Recordset1.Fields.Item("PI").Value)%>" class="style23"><strong>MEDIÇÕES</strong></a></div></td>
      <td bgcolor="#CCCCCC"><span class="style10"><%=(Recordset1.Fields.Item("PI").Value)%></span></td>
      <td bgcolor="#CCCCCC"><span class="style16"><%=(Recordset1.Fields.Item("cod_predio").Value)%></span></td>
      <td bgcolor="#CCCCCC"><span class="style17"><%=(Recordset1.Fields.Item("Nome_Unidade").Value)%></span></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("desc_diretoria").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Municipios").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Descrição da Intervenção FDE").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Critério de Cálculo").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Critério de Reajuste").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Número do Contrato").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Dígito do Contrato").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Data Base").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Data da Assinatura").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Data da Impressão da OIS").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Data da CI").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Data da Abertura").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Foi solicitado Aditamento?").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Prazo do Contrato").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Prazo do Aditamento").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Orçamento FDE").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Redução").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Valor do Contrato").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Valor do Aditamento").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Órgão").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Gerenciadora Mede ?").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Descrição da Intervenção Gerenciadora").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Fator de Redução").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Área gerenciada").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Data do TRP").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("É Medição Final ?").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Data do TRD").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Informação da Placa de Obra").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Transferência").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("novo contrato").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Responsável").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("Construtora").Value)%></td>
      <td bgcolor="#CCCCCC"><%=(Recordset1.Fields.Item("desc_situacao").Value)%></td>
    </tr>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  Recordset1.MoveNext()
Wend
%>
</table>
</body>
</html>
<%
Recordset1.Close()
Set Recordset1 = Nothing
%>
<%
Recordset2.Close()
Set Recordset2 = Nothing
%>
<%
Recordset4.Close()
Set Recordset4 = Nothing
%>