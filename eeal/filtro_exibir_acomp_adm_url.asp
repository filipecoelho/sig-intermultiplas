<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="Connections/cpf.asp" -->
<%
Dim rs_filtro_combo__MMColParam
rs_filtro_combo__MMColParam = "1"
If (Request.QueryString("cod_predio") <> "") Then 
  rs_filtro_combo__MMColParam = Request.QueryString("cod_predio")
End If
%>
<%
Dim rs_filtro_combo
Dim rs_filtro_combo_numRows

Set rs_filtro_combo = Server.CreateObject("ADODB.Recordset")
rs_filtro_combo.ActiveConnection = MM_cpf_STRING
rs_filtro_combo.Source = "SELECT * FROM tb_pi WHERE cod_predio = '" + Replace(rs_filtro_combo__MMColParam, "'", "''") + "'"
rs_filtro_combo.CursorType = 0
rs_filtro_combo.CursorLocation = 2
rs_filtro_combo.LockType = 1
rs_filtro_combo.Open()

rs_filtro_combo_numRows = 0
%>
<%
Dim rs_predio__MMColParam
rs_predio__MMColParam = "1"
If (Request.QueryString("cod_predio") <> "") Then 
  rs_predio__MMColParam = Request.QueryString("cod_predio")
End If
%>
<%
Dim rs_predio
Dim rs_predio_numRows

Set rs_predio = Server.CreateObject("ADODB.Recordset")
rs_predio.ActiveConnection = MM_cpf_STRING
rs_predio.Source = "SELECT cod_predio, Nome_Unidade FROM tb_predio WHERE cod_predio = '" + Replace(rs_predio__MMColParam, "'", "''") + "'"
rs_predio.CursorType = 0
rs_predio.CursorLocation = 2
rs_predio.LockType = 1
rs_predio.Open()

rs_predio_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 10
Repeat1__index = 0
rs_predio_numRows = rs_predio_numRows + Repeat1__numRows
%>
<%
Dim Repeat2__numRows
Dim Repeat2__index

Repeat2__numRows = 10
Repeat2__index = 0
rs_filtro_combo_numRows = rs_filtro_combo_numRows + Repeat2__numRows
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<style type="text/css">
<!--
.style9 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #FFFFFF; }
.style13 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000; }
.style15 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #333333; }
-->
</style>
</head>

<body>
<div align="center">
  <table border="0">
    <tr bgcolor="#666666">
      <td width="151"><span class="style9">cod_predio</span></td>
      <td width="427"><span class="style9">Nome_Unidade</span></td>
    </tr>
    <% While ((Repeat1__numRows <> 0) AND (NOT rs_predio.EOF)) %>
      <tr bgcolor="#CCCCCC">
        <td><span class="style13"><%=(rs_predio.Fields.Item("cod_predio").Value)%></span></td>
        <td><span class="style13"><%=(rs_predio.Fields.Item("Nome_Unidade").Value)%></span></td>
      </tr>
      <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rs_predio.MoveNext()
Wend
%>
  </table>
</div>
<p>&nbsp;</p>

<div align="center">
  <table border="0">
    <tr bgcolor="#666666">
      <td width="108"><span class="style9">PI</span></td>
      <td width="315"><span class="style9">Descri&ccedil;&atilde;o da Interven&ccedil;&atilde;o FDE</span></td>
    </tr>
    <% While ((Repeat2__numRows <> 0) AND (NOT rs_filtro_combo.EOF)) %>
      <tr bgcolor="#CCCCCC">
        <td><a href="acompanhamento_inclui.asp?pi=<%=(rs_filtro_combo.Fields.Item("PI").Value)%>" class="style15"><%=(rs_filtro_combo.Fields.Item("PI").Value)%></a></td>
        <td><span class="style15"><%=(rs_filtro_combo.Fields.Item("Descrição da Intervenção FDE").Value)%></span></td>
      </tr>
      <% 
  Repeat2__index=Repeat2__index+1
  Repeat2__numRows=Repeat2__numRows-1
  rs_filtro_combo.MoveNext()
Wend
%>
  </table>
   </div>
</body>
</html>
<%
rs_filtro_combo.Close()
Set rs_filtro_combo = Nothing
%>
<%
rs_predio.Close()
Set rs_predio = Nothing
%>