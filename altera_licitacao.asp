<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cpf.asp" -->
<%
' *** Edit Operations: declare variables

Response.CharSet = "UTF-8"
  
Dim objCon
Set objCon = Server.CreateObject("ADODB.Connection")
    objCon.Open MM_cpf_STRING

Dim MM_editAction
Dim MM_abortEdit
Dim MM_editQuery
Dim MM_editCmd

Dim MM_editConnection
Dim MM_editTable
Dim MM_editRedirectUrl
Dim MM_editColumn
Dim MM_recordId

Dim MM_fieldsStr
Dim MM_columnsStr
Dim MM_fields
Dim MM_columns
Dim MM_typeArray
Dim MM_formVal
Dim MM_delim
Dim MM_altVal
Dim MM_emptyVal
Dim MM_i

MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
MM_abortEdit = false

' query string to execute
MM_editQuery = ""
%>
<%
' *** Update Record: set variables

If (CStr(Request("MM_update")) = "form1" And CStr(Request("MM_recordId")) <> "") Then

  MM_editConnection = MM_cpf_STRING
  MM_editTable = "tb_licitacao"
  MM_editColumn = "id"
  MM_recordId = "" + Request.Form("MM_recordId") + ""
  MM_editRedirectUrl = "cad_licitacao.asp"
  MM_fieldsStr  = "num_autos|value|cod_tipo_contratacao|value|cod_financiador|value|cod_modalidade|value|num_edital|value|dta_publicacao_doe|value|dta_licitacao|value|cod_situacao_licitacao|value|vlr_licitacao|value"
  MM_columnsStr = "num_autos|',none,''|cod_tipo_contratacao|none,none,NULL|cod_financiador|none,none,NULL|cod_modalidade|none,none,NULL|num_edital|',none,''|dta_publicacao_doe|',none,NULL|dta_licitacao|',none,NULL|cod_situacao_licitacao|none,none,NULL|vlr_licitacao|',none,NULL"

  ' create the MM_fields and MM_columns arrays
  MM_fields = Split(MM_fieldsStr, "|")
  MM_columns = Split(MM_columnsStr, "|")
  
  ' set the form values
  For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_fields(MM_i+1) = CStr(Request.Form(MM_fields(MM_i)))
  Next

  ' append the query string to the redirect URL
  If (MM_editRedirectUrl <> "" And Request.QueryString <> "") Then
    If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
      MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
    Else
      MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
    End If
  End If

End If
%>
<%
' *** Update Record: construct a sql update statement and execute it

If (CStr(Request("MM_update")) <> "" And CStr(Request("MM_recordId")) <> "") Then

  ' create the sql update statement
  MM_editQuery = "update " & MM_editTable & " set "
  For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_formVal = MM_fields(MM_i+1)
    MM_typeArray = Split(MM_columns(MM_i+1),",")
    MM_delim = MM_typeArray(0)
    If (MM_delim = "none") Then MM_delim = ""
    MM_altVal = MM_typeArray(1)
    If (MM_altVal = "none") Then MM_altVal = ""
    MM_emptyVal = MM_typeArray(2)
    If (MM_emptyVal = "none") Then MM_emptyVal = ""
    If (MM_formVal = "") Then
      MM_formVal = MM_emptyVal
    Else
      If (MM_altVal <> "") Then
        MM_formVal = MM_altVal
      ElseIf (MM_delim = "'") Then  ' escape quotes
        MM_formVal = "'" & Replace(MM_formVal,"'","''") & "'"
      Else
        MM_formVal = MM_delim + MM_formVal + MM_delim
      End If
    End If
    If (MM_i <> LBound(MM_fields)) Then
      MM_editQuery = MM_editQuery & ","
    End If
    MM_editQuery = MM_editQuery & MM_columns(MM_i) & " = " & MM_formVal
  Next
  MM_editQuery = MM_editQuery & " where " & MM_editColumn & " = " & MM_recordId

  If (Not MM_abortEdit) Then
    ' execute the update
    Set MM_editCmd = Server.CreateObject("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_editConnection
    MM_editCmd.CommandText = MM_editQuery
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    If (MM_editRedirectUrl <> "") Then
      Response.Redirect(MM_editRedirectUrl)
    End If
  End If

End If
%>
<%
Dim rs__MMColParam
rs__MMColParam = "1"
If (Request.QueryString("id") <> "") Then 
  rs__MMColParam = Request.QueryString("id")
End If
%>
<%
Dim rs
Dim rs_numRows

Set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = MM_cpf_STRING
rs.Source = "SELECT * FROM tb_licitacao WHERE id = " + Replace(rs__MMColParam, "'", "''")
rs.CursorType = 0
rs.CursorLocation = 2
rs.LockType = 1
rs.Open()

rs_numRows = 0
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<style type="text/css">
<!--
.style17 {	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
}
.style44 {font-family: Arial, Helvetica, sans-serif; font-size: 9; font-weight: bold; }
.style45 {font-size: 9}
.style22 {font-family: Arial, Helvetica, sans-serif; font-size: 9; }
.style7 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; }
-->
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/datepicker-pt-BR.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js"></script>
    <script type="text/javascript">
      $(document).ready(function() {
        $(".datepicker").datepicker($.datepicker.regional["pt-BR"]);
      });
    </script>
</head>

<body>
<p align="center"><strong><span class="style17">Alteração de Licitação </span></strong></p>
    <form method="post" action="<%=MM_editAction%>" name="form1">
      <input type="hidden" name="MM_update" value="form1">
      <input type="hidden" name="MM_recordId" value="<%= rs.Fields.Item("id").Value %>">
      <table align="center">
        <tr valign="baseline">
          <td align="right" nowrap bgcolor="#CCCCCC" class="style7">
            <span class="style22">Núm. Autos Licitação:</span>
          </td>
          <td bgcolor="#CCCCCC">
            <input type="text" name="num_autos" value="<%=(rs.Fields.Item("num_autos").Value)%>" size="10">
          </td>
        </tr>
        <tr valign="baseline">
          <td align="right" nowrap bgcolor="#CCCCCC" class="style7">
            <span class="style22">Tipo de Contratação:</span>
          </td>
          <td bgcolor="#CCCCCC">
            <select name="cod_tipo_contratacao">
              <option value=""></option>
              <%
                strQ = "SELECT * FROM tb_tipo_contratacao"

                Set rs_combo = Server.CreateObject("ADODB.Recordset")
                  rs_combo.CursorLocation = 3
                  rs_combo.CursorType = 3
                  rs_combo.LockType = 1
                  rs_combo.Open strQ, objCon, , , &H0001

                If Not rs_combo.EOF Then
                  While Not rs_combo.EOF
                    If Trim(rs_combo.Fields.Item("dsc_tipo_contratacao").Value) <> "" Then
                      Response.Write "      <OPTION value='" & (rs_combo.Fields.Item("id").Value) & "'"
                      If Lcase(rs_combo.Fields.Item("id").Value) = Lcase(rs.Fields.Item("cod_tipo_contratacao").Value) then
                        Response.Write "selected"
                      End If
                      Response.Write ">" & (rs_combo.Fields.Item("dsc_tipo_contratacao").Value) & "</OPTION>"
                    End If
                    rs_combo.MoveNext
                  Wend
                End If
              %>
            </select>
          </td>
        </tr>
        <tr valign="baseline">
          <td align="right" nowrap bgcolor="#CCCCCC" class="style7">
            <span class="style22">Financiador:</span>
          </td>
          <td bgcolor="#CCCCCC">
            <select name="cod_financiador">
              <option value=""></option>
              <%
                strQ = "SELECT * FROM tb_financiador_licitacao"

                Set rs_combo = Server.CreateObject("ADODB.Recordset")
                  rs_combo.CursorLocation = 3
                  rs_combo.CursorType = 3
                  rs_combo.LockType = 1
                  rs_combo.Open strQ, objCon, , , &H0001

                If Not rs_combo.EOF Then
                  While Not rs_combo.EOF
                    If Trim(rs_combo.Fields.Item("dsc_financiador").Value) <> "" Then
                      Response.Write "      <OPTION value='" & (rs_combo.Fields.Item("id").Value) & "'"
                      If Lcase(rs_combo.Fields.Item("id").Value) = Lcase(rs.Fields.Item("cod_financiador").Value) then
                        Response.Write "selected"
                      End If
                      Response.Write ">" & (rs_combo.Fields.Item("dsc_financiador").Value) & "</OPTION>"
                    End If
                    rs_combo.MoveNext
                  Wend
                End If
              %>
            </select>
          </td>
        </tr>
        <tr valign="baseline">
          <td align="right" nowrap bgcolor="#CCCCCC" class="style7">
            <span class="style22">Modalidade de Contratação:</span>
          </td>
          <td bgcolor="#CCCCCC">
            <select name="cod_modalidade">
              <option value=""></option>
              <%
                strQ = "SELECT * FROM tb_modalidade_licitacao"

                Set rs_combo = Server.CreateObject("ADODB.Recordset")
                  rs_combo.CursorLocation = 3
                  rs_combo.CursorType = 3
                  rs_combo.LockType = 1
                  rs_combo.Open strQ, objCon, , , &H0001

                If Not rs_combo.EOF Then
                  While Not rs_combo.EOF
                    If Trim(rs_combo.Fields.Item("dsc_modalidade").Value) <> "" Then
                      Response.Write "      <OPTION value='" & (rs_combo.Fields.Item("id").Value) & "'"
                      If Lcase(rs_combo.Fields.Item("id").Value) = Lcase(rs.Fields.Item("cod_modalidade").Value) then
                        Response.Write "selected"
                      End If
                      Response.Write ">" & (rs_combo.Fields.Item("dsc_modalidade").Value) & "</OPTION>"
                    End If
                    rs_combo.MoveNext
                  Wend
                End If
              %>
            </select>
          </td>
        </tr>
        <tr valign="baseline">
          <td align="right" nowrap bgcolor="#CCCCCC" class="style7">
            <span class="style22">Núm. Edital:</span>
          </td>
          <td bgcolor="#CCCCCC">
            <input type="text" name="num_edital" value="<%=(rs.Fields.Item("num_edital").Value)%>" size="10">
          </td>
        </tr>
        <tr valign="baseline">
          <td align="right" nowrap bgcolor="#CCCCCC" class="style7">
            <span class="style22">Data de Publicação D.O.E:</span>
          </td>
          <td bgcolor="#CCCCCC">
            <input type="text" class="datepicker" name="dta_publicacao_doe" value="<%=(rs.Fields.Item("dta_publicacao_doe").Value)%>" size="32">
          </td>
        </tr>
        <tr valign="baseline">
          <td align="right" nowrap bgcolor="#CCCCCC" class="style7">
            <span class="style22">Data da Licitação:</span>
          </td>
          <td bgcolor="#CCCCCC">
            <input type="text" class="datepicker" name="dta_licitacao" value="<%=(rs.Fields.Item("dta_licitacao").Value)%>" size="32">
          </td>
        </tr>
        <tr valign="baseline">
          <td align="right" nowrap bgcolor="#CCCCCC" class="style7">
            <span class="style22">Valor Estimado</span>
          </td>
          <td bgcolor="#CCCCCC">
            <input type="text" name="vlr_licitacao" value="<%=(rs.Fields.Item("vlr_licitacao").Value)%>" size="32">
          </td>
        </tr>
        <tr valign="baseline">
          <td align="right" nowrap bgcolor="#CCCCCC" class="style7">
            <span class="style22">Status/Situação:</span>
          </td>
          <td bgcolor="#CCCCCC">
            <select name="cod_situacao_licitacao">
              <option value=""></option>
              <%
                strQ = "SELECT * FROM tb_situacao_licitacao"

                Set rs_combo = Server.CreateObject("ADODB.Recordset")
                  rs_combo.CursorLocation = 3
                  rs_combo.CursorType = 3
                  rs_combo.LockType = 1
                  rs_combo.Open strQ, objCon, , , &H0001

                If Not rs_combo.EOF Then
                  While Not rs_combo.EOF
                    If Trim(rs_combo.Fields.Item("dsc_situacao").Value) <> "" Then
                      Response.Write "      <OPTION value='" & (rs_combo.Fields.Item("id").Value) & "'"
                      If Lcase(rs_combo.Fields.Item("id").Value) = Lcase(rs.Fields.Item("cod_situacao_licitacao").Value) then
                        Response.Write "selected"
                      End If
                      Response.Write ">" & (rs_combo.Fields.Item("dsc_situacao").Value) & "</OPTION>"
                    End If
                    rs_combo.MoveNext
                  Wend
                End If
              %>
            </select>
          </td>
        </tr>
        <tr valign="baseline">
          <td align="right" nowrap bgcolor="#CCCCCC" class="style7">&nbsp;</td>
          <td bgcolor="#CCCCCC">
            <input type="submit" value="Salvar">
          </td>
        </tr>
      </table>
    </form>
<p>&nbsp;</p>
</body>
</html>
<%
rs.Close()
Set rs = Nothing
%>