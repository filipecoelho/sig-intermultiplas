<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cpf.asp" -->
<!--#include file="functions.asp" -->
<%
	Response.CharSet = "UTF-8"
	
	Dim objCon
	Set objCon = Server.CreateObject("ADODB.Connection")
  		objCon.Open MM_cpf_STRING

	If Not IsEmpty(Request.Form) Then
		strQ = "SELECT * FROM tb_contrato_medicao Where 1 <> 1"

		Set rs_update = Server.CreateObject("ADODB.Recordset")
			rs_update.CursorLocation = 3
			rs_update.CursorType = 0
			rs_update.LockType = 3
			rs_update.Open strQ, objCon, , , &H0001
			rs_update.Addnew()
			
			' INÍCIO CAMPOS
			
			rs_update("cod_contrato") 	= Trim(Request.Form("cod_contrato"))

			If Request.Form("num_autos") <> "" Then
				rs_update("num_autos") = Trim(Request.Form("num_autos"))
			End If

			If Request.Form("dta_medicao") <> "" Then
				rs_update("dta_medicao") 	= Trim(Request.Form("dta_medicao"))
			End If

			' FIM CAMPOS
			
			rs_update.Update
	End If

	Dim rs
	Dim rs_numRows

	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = MM_cpf_STRING
	rs.Source = "SELECT * FROM tb_contrato_medicao WHERE cod_contrato = " & Request.QueryString("cod_contrato")
	rs.CursorType = 0
	rs.CursorLocation = 2
	rs.LockType = 1
	rs.Open()

	rs_numRows = 0
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Untitled Document</title>
		<style type="text/css">
			<!--
				.style5 {font-family: Arial, Helvetica, sans-serif; font-size: 12px;}
				.style7 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold;}
				.style17 {font-family: Arial, Helvetica, sans-serif; font-size: 16px;}
				.style22 {font-family: Arial, Helvetica, sans-serif; font-size: 9;}
				.style23 {font-size: 9}
			-->
		</style>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
		<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/datepicker-pt-BR.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js"></script>
		<script type="text/javascript" src="js/jquery.number.min.js"></script>
		<script type="text/javascript">
			function adjustVlrLayout() {
				$.each($(".vlr"), function(i, item){
					// $(item).val($.number($(item).val(), 0, ",", "."));
					if($(item).text() != "")
						$(item).text("R$ " + $.number($(item).text(), 2, ",", "."));
				});
			}

			$(function(){
				adjustVlrLayout();
				$(".datepicker").datepicker($.datepicker.regional["pt-BR"]);
				$(".datepicker").datepicker("option", "dateFormat", "mm/yy");
			});
		</script>
	</head>

	<body>
		<p align="center">
			<strong>
				<span class="style17">Cadastro de Medições do Contrato</span>
			</strong>
		</p>

		<form method="post" name="form1">
			<input type="hidden" name="cod_contrato" value="<%=(Request.QueryString("cod_contrato"))%>">
			<table align="center">
				<tr valign="baseline">
					<td align="right" nowrap bgcolor="#CCCCCC" class="style7">
						<span class="style22">Nº Autos - Contrato:</span>
					</td>
					<td bgcolor="#CCCCCC">
						<span class="style22"><%=(Request.QueryString("num_autos"))%></span>
					</td>
				</tr>
				<tr valign="baseline">
					<td align="right" nowrap bgcolor="#CCCCCC" class="style7">
						<span class="style22">Núm. Autos Medição:</span>
					</td>
					<td bgcolor="#CCCCCC">
						<input type="text" name="num_autos" value="" size="10">
					</td>
				</tr>
				<tr valign="baseline">
					<td align="right" nowrap bgcolor="#CCCCCC" class="style7">
						<span class="style22">Período Medição:</span>
					</td>
					<td bgcolor="#CCCCCC">
						<input type="text" name="dta_medicao" class="datepicker" value="" size="5" style="text-align: center;">
					</td>
				</tr>
				<tr valign="baseline">
					<td bgcolor="#CCCCCC" colspan="2" align="center">
						<input type="submit" value="Cadastrar nova medição">
					</td>
				</tr>
			</table>
		</form>

		<div align="center">
			<table border="0">
				<tr bgcolor="#999999">
					<td>&nbsp;</td>
					<td>
						<span class="style7">Núm. Autos Medição</span>
					</td>
					<td>
						<span class="style7">Período Medição</span>
					</td>
					<td>
						<span class="style7">Valor Pago</span>
					</td>
					<td>&nbsp;</td>
				</tr>
				<%
					cod_contrato = Request.QueryString("cod_contrato")
					strQ = "SELECT tb_contrato_medicao.*, Month([dta_medicao]) AS mes_medicao, Year([dta_medicao]) AS ano_medicao, tb_contrato_pagamento.vlr_pagamento FROM tb_contrato_pagamento RIGHT JOIN tb_contrato_medicao ON tb_contrato_pagamento.cod_medicao = tb_contrato_medicao.id WHERE tb_contrato_medicao.cod_contrato = " & cod_contrato & " ORDER BY tb_contrato_medicao.id ASC"

					Set rs_lista = Server.CreateObject("ADODB.Recordset")
						rs_lista.CursorLocation = 3
						rs_lista.CursorType = 3
						rs_lista.LockType = 1
						rs_lista.Open strQ, objCon, , , &H0001

					If Not rs_lista.EOF Then
						i = 0

						While Not rs_lista.EOF
							i = i + 1
							If rs_lista.Fields.Item("mes_medicao").Value <> "" And rs_lista.Fields.Item("ano_medicao").Value <> "" Then
								mes = Trim(CaptalizeText(MonthName(rs_lista.Fields.Item("mes_medicao").Value,True)))
								ano = Trim(rs_lista.Fields.Item("ano_medicao").Value)
							End If
				%>
				<tr bgcolor="#CCCCCC">
					<td>
						<a href="delete_contrato_medicao.asp?id=<%=(rs_lista.Fields.Item("id").Value)%>&cod_contrato=<%=(Request.QueryString("cod_contrato"))%>&num_autos=<%=(Request.QueryString("num_autos"))%>&dta_medicao=<%=(rs_lista.Fields.Item("dta_medicao").Value)%>&mes_ano_medicao=<%=(mes)%>/<%=(ano)%>">
							<img src="const/imagens/delete.gif" width="16" height="15" border="0" />
						</a>
					</td>
					<td>
						<span class="style5">
							<%=(rs_lista.Fields.Item("num_autos").Value)%>
						</span>
					</td>
					<td align="center">
						<span class="style5">
							<%=(mes)%>/<%=(ano)%>
						</span>
					</td>
					<td align="center">
						<%
							If rs_lista.Fields.Item("vlr_pagamento").Value <> "" Then
						%>
							<span class="style5 vlr">
								<%=(rs_lista.Fields.Item("vlr_pagamento").Value)%>
							</span>
						<%
							Else
						%>
						<a href="cad_contrato_pagamento.asp?cod_medicao=<%=(rs_lista.Fields.Item("id").Value)%>&cod_contrato=<%=(Request.QueryString("cod_contrato"))%>&num_autos=<%=(Request.QueryString("num_autos"))%>&dta_medicao=<%=(rs_lista.Fields.Item("dta_medicao").Value)%>&mes_ano_medicao=<%=(mes)%>/<%=(ano)%>">
							<span class="style5">
								Registrar Pagamento
							</span>
						</a>
						<%
							End If
						%>
					</td>
					<td>
						<a href="cad_contrato_medicao_item.asp?cod_medicao=<%=(rs_lista.Fields.Item("id").Value)%>&cod_contrato=<%=(Request.QueryString("cod_contrato"))%>&num_autos=<%=(Request.QueryString("num_autos"))%>&dta_medicao=<%=(rs_lista.Fields.Item("dta_medicao").Value)%>&mes_ano_medicao=<%=(mes)%>/<%=(ano)%>">
							<span class="style5">
								Lançamento de Itens
							</span>
						</a>
					</td>
				</tr>
				<%
							rs_lista.MoveNext
						Wend
					End If
				%>
			</table>
		</div>
	</body>
</html>